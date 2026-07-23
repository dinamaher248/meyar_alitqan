import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';

abstract class MarkNotificationAsReadRemoteDataSource {
  Future<Either<Failures, void>> markAllNotificationsAsRead();
}