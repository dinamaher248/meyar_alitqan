import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';


abstract class SendNotificationsRemoteDataSource {
  Future<Either<Failures, void>> sendNotification({
    String? userId,
    String? userRole,
    required String title,
    required String body,
  });
}
