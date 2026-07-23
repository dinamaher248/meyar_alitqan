import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../core/api/api_end_points.dart';
import '../../../../../../../../core/api/api_manager.dart';
import '../../../../../../../../core/errors/failures.dart';
import '../../../../../../../../core/helper/app_messages.dart';
import '../../../../../../../../core/helper/network_validation.dart';
import '../../../../data_sources/remote/orders_remote_data_source/update_order_status_remote_data_source/update_order_status_remote_data_source.dart';

@Injectable(as: UpdateOrderStatusRemoteDataSource)
class UpdateOrderStatusRemoteDataSourceImpl
    implements UpdateOrderStatusRemoteDataSource {

  final ApiManager apiManager = ApiManager();

  @override
  Future<Either<Failures, void>> updateOrderStatus(
      String orderId,
      String status,
      ) async {
    try {
      // 1️⃣ Check internet
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      // 2️⃣ Get access token
      final accessToken =
          Supabase.instance.client.auth.currentSession?.accessToken;

      if (accessToken == null) {
        return Left(ServerFailure('ACCESS_TOKEN_NOT_FOUND'));
      }

      // 3️⃣ Call Edge Function
      final response = await apiManager.post(
        url: ApiEndPoints.updateOrderStatus,
        token: accessToken,
        body: {
          "order_id": orderId,
          "status": status,
        },
      );

      // 4️⃣ Handle response
      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(
          ServerFailure(response.data?.toString() ?? AppMessages.serverError),
        );
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
