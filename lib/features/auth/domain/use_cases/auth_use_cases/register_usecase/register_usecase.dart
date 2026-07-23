import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../data/models/auth/send_otp_response/send_otp_response.dart';
import '../../../entities/auth/auth_user_entity/auth_user_entity.dart';
import '../../../repositories/auth_repositories/register_repo/register_repo.dart';
@injectable
class RegisterUseCase {
  final RegisterRepo registerRepo;

  RegisterUseCase(this.registerRepo);

  Future<Either<Failures, SendOtpResponse>>registerUser({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String role,
  }) {
    return registerRepo.registerUser(
      email: email,
      password: password,
      fullName: fullName,
      phone: phone,
      role: role,
    );
  }
}