import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/auth/domain/repositories/auth_repositories/register_repo/register_repo.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../entities/auth/auth_user_entity/auth_user_entity.dart';
@injectable
class VerifyOtpUseCase {
    final RegisterRepo registerRepo ;
    VerifyOtpUseCase({required this.registerRepo});
    Future<Either<Failures, AuthUserEntity>> verifyOtp({
      required String email,
      required String otp,
    }) {
      return registerRepo.verifyOtp(
        email: email,
        otp: otp,
      );
    }

}