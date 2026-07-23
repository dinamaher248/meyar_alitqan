import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';


abstract class DeleteNotificationDataRemoteDataSource {
  Future<Either<Failures, void>> deleteNotificationData(String notificationId);
}