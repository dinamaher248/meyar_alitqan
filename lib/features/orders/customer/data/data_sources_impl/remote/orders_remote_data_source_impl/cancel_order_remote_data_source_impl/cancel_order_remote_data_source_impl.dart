import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/api/api_end_points.dart';
import 'package:meayar_alitqan/core/api/api_manager.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/core/helper/app_messages.dart';
import 'package:meayar_alitqan/core/helper/network_validation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../data_sources/remote/orders_remote_data_source/cancel_order_remote_data_source/cancel_order_remote_data_source.dart';
@Injectable(as: CancelOrderRemoteDataSource)
class CancelOrderRemoteDataSourceImpl
    implements CancelOrderRemoteDataSource {
  final ApiManager apiManager = ApiManager();

  @override
  Future<Either<Failures, void>> cancelOrder(String orderId) async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }
      final session = Supabase.instance.client.auth.currentSession;
      final accessToken = session?.accessToken;

      if (accessToken == null) {
        return Left(ServerFailure("User not authenticated"));
      }

      final response = await apiManager.post(
        url: ApiEndPoints.cancelOrder,
        body: {
          "order_id": orderId,
        },
        token: accessToken,
      );

      if (response.data['success'] != true) {
        return Left(
          ServerFailure(
            response.data['error'] ?? AppMessages.serverError,
          ),
        );
      }

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
