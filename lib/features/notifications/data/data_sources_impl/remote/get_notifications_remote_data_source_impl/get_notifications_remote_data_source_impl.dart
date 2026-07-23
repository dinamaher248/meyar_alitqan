import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/api/api_end_points.dart';
import 'package:meayar_alitqan/core/api/api_manager.dart';
import 'package:meayar_alitqan/core/helper/app_messages.dart';
import 'package:meayar_alitqan/core/helper/network_validation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/notification_entity.dart';
import '../../../data_sources/remote/get_notifications_remote_data_source/get_notifications_remote_data_source.dart';



@Injectable(as: GetNotificationsRemoteDataSource)
class GetNotificationsRemoteDataSourceImpl
    implements GetNotificationsRemoteDataSource {
  final ApiManager apiManager = ApiManager();

  @override
  Future<Either<Failures, List<NotificationEntity>>> getNotifications() async {
    try {
      // 1️⃣ Check internet
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      // 2️⃣ Get access token
      final session = Supabase.instance.client.auth.currentSession;
      final accessToken = session?.accessToken;

      if (accessToken == null) {
        return Left(ServerFailure('User not authenticated'));
      }

      // 3️⃣ Call API
      final response = await apiManager.get(
        url: ApiEndPoints.getNotifications,
        token: accessToken,

      );

      // 4️⃣ Parse response
      final List<dynamic> data = response.data as List<dynamic>;

      final notifications = data
          .map(
            (e) => NotificationEntity(
          id: e['id'],
          title: e['title'],
          body: e['body'],
          isRead: e['is_read'] ?? false,
          isDeleted: e['is_deleted'] ?? false,
          createdAt: DateTime.parse(e['created_at']),


        ),
      )
          .toList();

      return Right(notifications);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
