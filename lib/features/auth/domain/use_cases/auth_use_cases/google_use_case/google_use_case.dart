import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../entities/auth/auth_user_entity/auth_user_entity.dart';
import '../../../repositories/auth_repositories/google_repo/google_repo.dart';

@injectable
class GoogleUseCase {
  GoogleRepo googleRepo;

  GoogleUseCase(this.googleRepo);

  Future<Either<Failures, AuthUserEntity>> signInWithGoogle() {
    return googleRepo.signInWithGoogle();
  }
}
