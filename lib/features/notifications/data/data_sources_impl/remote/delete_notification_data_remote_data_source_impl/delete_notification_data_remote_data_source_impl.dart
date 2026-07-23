import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/api/api_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../core/api/api_end_points.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/helper/app_messages.dart';
import '../../../../../../core/helper/network_validation.dart';
import '../../../data_sources/remote/delete_notification_data_remote_data_source/delete_notification_data_remote_data_source.dart';
@Injectable(as: DeleteNotificationDataRemoteDataSource)
class DeleteNotificationDataRemoteDataSourceImpl
    implements DeleteNotificationDataRemoteDataSource {
  final ApiManager apiManager = ApiManager();

  @override
  Future<Either<Failures, void>> deleteNotificationData(
      String notificationId,
      ) async {
    try {
      // 🌐 Check internet
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      // 🔐 Auth
      final session = Supabase.instance.client.auth.currentSession;
      final accessToken = session?.accessToken;

      if (accessToken == null) {
        return Left(ServerFailure('User not authenticated'));
      }

      // 📡 Call soft_delete_notification (PATCH)
      await apiManager.patch(
        url: ApiEndPoints.deleteNotification,
        token: accessToken,
        body: {
          'notification_id': notificationId,
        },
      );

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
