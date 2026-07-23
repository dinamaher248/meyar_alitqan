import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../entities/auth/auth_user_entity/auth_user_entity.dart';
import '../../../repositories/auth_repositories/login_repo/login_repo.dart';
@injectable
class LoginUseCase {
  final LoginRepo loginRepo;

  LoginUseCase(this.loginRepo);

  Future<Either<Failures, AuthUserEntity>> loginUser({
    required String email,
    required String password,
  }) {
    return loginRepo.loginUser(email: email, password: password);
  }
}