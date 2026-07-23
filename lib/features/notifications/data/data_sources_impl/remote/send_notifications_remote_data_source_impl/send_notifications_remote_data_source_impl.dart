import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../core/api/api_end_points.dart';
import '../../../../../../core/api/api_manager.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/helper/app_messages.dart';
import '../../../../../../core/helper/network_validation.dart';
import '../../../data_sources/remote/send_notifications_remote_data_source/send_notifications_remote_data_source.dart';
@Injectable(as: SendNotificationsRemoteDataSource)
class SendNotificationsRemoteDataSourceImpl
    implements SendNotificationsRemoteDataSource {
  final ApiManager apiManager = ApiManager();

  @override
  Future<Either<Failures, void>> sendNotification({
    String? userId,
    String? userRole,
    required String title,
    required String body,
  }) async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      if (userId == null && userRole == null) {
        return Left(ServerFailure('userId or userRole is required'));
      }

      final session = Supabase.instance.client.auth.currentSession;
      final accessToken = session?.accessToken;

      if (accessToken == null) {
        return Left(ServerFailure('User not authenticated'));
      }

      await apiManager.post(
        url: ApiEndPoints.sendNotification,
        token: accessToken,
        body: {
          'title': title,
          'body': body,
          if (userId != null) 'user_id': userId,
          if (userRole != null) 'user_role': userRole,
        },
      );

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
