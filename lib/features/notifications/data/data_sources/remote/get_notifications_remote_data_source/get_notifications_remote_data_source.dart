import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/notification_entity.dart';



abstract class GetNotificationsRemoteDataSource {
  Future<Either<Failures, List<NotificationEntity>>> getNotifications();
}