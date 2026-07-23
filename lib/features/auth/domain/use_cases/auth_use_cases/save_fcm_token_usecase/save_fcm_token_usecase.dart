import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../repositories/auth_repositories/save_fcm_token_repo/save_fcm_token_repo.dart';
@injectable
class SaveFcmTokenUseCase {
  final SaveFcmTokenRepo saveFcmTokenRepo;

  SaveFcmTokenUseCase(this.saveFcmTokenRepo);

  Future<Either<Failures, bool>>  saveFcmToken({
    required String token,
    required String platform,
  }) {
    return saveFcmTokenRepo.saveFcmToken(
      token: token,
      platform: platform,
    );
  }
}