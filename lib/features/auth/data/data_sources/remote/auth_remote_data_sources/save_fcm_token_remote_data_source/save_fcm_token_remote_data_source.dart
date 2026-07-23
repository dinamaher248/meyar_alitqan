import 'package:either_dart/either.dart';

import '../../../../../../../core/errors/failures.dart';

abstract class SaveFcmTokenRemoteDataSource {
  Future<Either<Failures, bool>> saveFcmToken({
    required String token,
    required String platform,
  });

}