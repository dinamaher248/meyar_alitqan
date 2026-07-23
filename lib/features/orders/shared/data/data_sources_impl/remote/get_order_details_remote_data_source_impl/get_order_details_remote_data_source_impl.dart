import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/api/api_end_points.dart';
import '../../../../../../../core/api/api_manager.dart';
import '../../../../../../../core/errors/failures.dart';
import '../../../../../../../core/helper/app_messages.dart';
import '../../../../../../../core/helper/network_validation.dart';
import '../../../../domain/entities/order_entity/order_entity.dart';
import '../../../data_sources/remote/get_order_details_remote_data_source/get_order_details_remote_data_source.dart';
import '../../../models/order_model/order_model.dart';

@Injectable(as: GetOrderDetailsRemoteDataSource)
class GetOrderDetailsRemoteDataSourceImpl
    implements GetOrderDetailsRemoteDataSource {

  final ApiManager apiManager = ApiManager();

  @override
  Future<Either<Failures, OrderEntity>> getOrderDetails(String orderId) async {
    try {
      // 1️⃣ Check internet
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      // 2️⃣ Call API
      final response = await apiManager.post(
        url: ApiEndPoints.getOrderDetails,
        body: {
          "order_id": orderId,
        },
      );

      // 3️⃣ Check success
      if (response.data['success'] != true) {
        return Left(
          ServerFailure(response.data['error'] ?? AppMessages.serverError),
        );
      }

      // 4️⃣ Parse order
      final order = OrderModel.fromJson(response.data['data']);

      return Right(order);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
