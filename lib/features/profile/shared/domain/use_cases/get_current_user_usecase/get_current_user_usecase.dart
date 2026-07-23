import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../entities/base_profile_entity/base_profile_entity.dart';
import '../../repositories/get_current_user_repo/get_current_user_repo.dart';
@injectable
class GetCurrentUserUseCase {
  final GetCurrentUserRepo getCurrentUserRepo;

  GetCurrentUserUseCase(this.getCurrentUserRepo);

  Future<Either<Failures, BaseProfileEntity>> getCurrentUser({ required String accessToken,}) {
    return getCurrentUserRepo.getCurrentUser(accessToken: accessToken);
  }
}