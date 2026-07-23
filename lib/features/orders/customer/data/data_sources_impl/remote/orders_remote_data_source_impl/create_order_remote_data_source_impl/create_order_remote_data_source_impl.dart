import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../core/api/api_end_points.dart';
import '../../../../../../../../core/api/api_manager.dart';
import '../../../../../../../../core/errors/failures.dart';
import '../../../../../../../../core/helper/app_messages.dart';
import '../../../../../../../../core/helper/network_validation.dart';
import '../../../../../../shared/data/models/order_model/order_model.dart';
import '../../../../../../shared/domain/entities/order_entity/order_entity.dart';
import '../../../../data_sources/remote/orders_remote_data_source/create_order_remote_data_source/create_order_remote_data_source.dart';

@Injectable(as: CreateOrderRemoteDataSource)
class CreateOrderRemoteDataSourceImpl implements CreateOrderRemoteDataSource {
  final ApiManager apiManager = ApiManager();

  @override
  Future<Either<Failures, OrderEntity>> createOrder(OrderModel  order) async {
    try {
      // 1️⃣ Check internet
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      final session = Supabase.instance.client.auth.currentSession;
      final accessToken = session?.accessToken;

      if (accessToken == null) {
        return Left(ServerFailure("User not authenticated"));
      }

      final response = await apiManager.post(
        url: ApiEndPoints.createOrder,
        token: accessToken,
        body: order.toJson(),
      );


      // 3️⃣ Check success
      if (response.data['success'] != true) {
        return Left(
          ServerFailure(response.data['error'] ?? AppMessages.serverError),
        );
      }

      final createdOrder = OrderModel.fromJson(response.data['data']);

      return Right(createdOrder);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
