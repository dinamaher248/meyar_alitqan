
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../core/api/api_end_points.dart';
import '../../../../../../core/api/api_manager.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/helper/app_messages.dart';
import '../../../../../../core/helper/network_validation.dart';
import '../../../data_sources/remote/unread_notifications_count_remote_data_source/unread_notifications_count_remote_data_source.dart';
@Injectable(as: UnreadNotificationsCountRemoteDataSource)
class UnreadNotificationsCountRemoteDataSourceImpl
    implements UnreadNotificationsCountRemoteDataSource {
  final ApiManager apiManager = ApiManager();

  @override
  Future<Either<Failures, int>> getUnreadNotificationsCount() async {
    try {
      // 1️⃣ Check internet
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      // 2️⃣ Auth
      final session = Supabase.instance.client.auth.currentSession;
      final accessToken = session?.accessToken;

      if (accessToken == null) {
        return Left(ServerFailure('User not authenticated'));
      }

      // 3️⃣ Call API
      final response = await apiManager.get(
        url: ApiEndPoints.unreadNotificationCount,
        token: accessToken,
      );

      // 4️⃣ Parse
      final data = response.data as Map<String, dynamic>;
      final count = data['unread'] as int;


      return Right(count);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
