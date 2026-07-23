import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../entities/auth/auth_user_entity/auth_user_entity.dart';
import '../../../repositories/auth_repositories/logout_repo/logout_repo.dart';

class LogoutUseCase {
  final LogoutRepo logoutRepo;

  LogoutUseCase(this.logoutRepo);

  Future<Either<Failures, AuthUserEntity>> logoutUser() {
    return logoutRepo.logoutUser();
  }
}