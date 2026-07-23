import 'package:either_dart/either.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/notification_entity.dart';

abstract class GetNotificationsRepo {
  Future<Either<Failures, List<NotificationEntity>>> getNotifications();
}