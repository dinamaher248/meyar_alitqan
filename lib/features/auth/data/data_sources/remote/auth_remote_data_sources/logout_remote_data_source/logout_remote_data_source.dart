import 'package:either_dart/either.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../domain/entities/auth/auth_user_entity/auth_user_entity.dart';

abstract class LogoutRemoteDataSource {
  Future<Either<Failures, AuthUserEntity>> logout();
}