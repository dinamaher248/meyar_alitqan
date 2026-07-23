import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';

abstract class SaveFcmTokenRepo {
  Future<Either<Failures, bool>>  saveFcmToken({
    required String token,
    required String platform,
  });
}