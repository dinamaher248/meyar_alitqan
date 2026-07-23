import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../entities/auth/auth_user_entity/auth_user_entity.dart';

abstract class LogoutRepo {
  Future<Either<Failures, AuthUserEntity>> logoutUser();
}