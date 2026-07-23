import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../entities/base_profile_entity/base_profile_entity.dart';

abstract class GetCurrentUserRepo {
  Future<Either<Failures, BaseProfileEntity>> getCurrentUser({ required String accessToken});
}