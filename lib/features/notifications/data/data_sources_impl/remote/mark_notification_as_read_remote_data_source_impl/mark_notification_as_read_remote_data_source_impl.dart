import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../core/api/api_end_points.dart';
import '../../../../../../core/api/api_manager.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/helper/app_messages.dart';
import '../../../../../../core/helper/network_validation.dart';
import '../../../data_sources/remote/mark_notification_as_read_remote_data_source/mark_notification_as_read_remote_data_source.dart';
@Injectable(as: MarkNotificationAsReadRemoteDataSource)
class MarkNotificationAsReadRemoteDataSourceImpl
    implements MarkNotificationAsReadRemoteDataSource {
  final ApiManager apiManager = ApiManager();

  @override
  Future<Either<Failures, void>> markAllNotificationsAsRead(

      ) async {
    try {
      // 1️⃣ Internet check
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      // 2️⃣ Auth check
      final session = Supabase.instance.client.auth.currentSession;
      final accessToken = session?.accessToken;

      if (accessToken == null) {
        return Left(ServerFailure('User not authenticated'));
      }

      // 3️⃣ Call API
      await apiManager.put(
        url: ApiEndPoints.markAllNotificationsAsRead,
        token: accessToken,

      );

      // 4️⃣ Success
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
