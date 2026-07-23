import 'package:either_dart/either.dart';
import 'package:meayar_alitqan/features/auth/domain/entities/auth/auth_user_entity/auth_user_entity.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../data/models/auth/send_otp_response/send_otp_response.dart';

abstract class RegisterRepo {
  Future<Either<Failures, SendOtpResponse>> registerUser({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String role,
  });
  Future<Either<Failures, AuthUserEntity>> verifyOtp({
    required String email,
    required String otp,
  });
}
