import 'package:either_dart/either.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../domain/entities/auth/auth_user_entity/auth_user_entity.dart';
import '../../../../models/auth/send_otp_response/send_otp_response.dart';

abstract class RegisterRemoteDataSource {
  Future<Either<Failures, SendOtpResponse>>register({
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