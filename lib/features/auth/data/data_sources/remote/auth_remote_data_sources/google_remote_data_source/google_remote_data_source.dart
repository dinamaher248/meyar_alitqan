import 'package:either_dart/either.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../domain/entities/auth/auth_user_entity/auth_user_entity.dart';

abstract  class GoogleRemoteDataSource {
  Future<Either<Failures, AuthUserEntity>> signInWithGoogle();
}