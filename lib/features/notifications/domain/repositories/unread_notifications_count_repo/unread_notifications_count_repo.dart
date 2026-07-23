import 'package:either_dart/either.dart';

import '../../../../../core/errors/failures.dart';

abstract class UnreadNotificationsCountRepo {
  Future<Either<Failures, int>> getUnreadNotificationsCount();
}