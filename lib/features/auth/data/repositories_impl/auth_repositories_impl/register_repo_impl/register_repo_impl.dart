import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/auth/auth_user_entity/auth_user_entity.dart';
import '../../../../domain/repositories/auth_repositories/register_repo/register_repo.dart';
import '../../../data_sources/remote/auth_remote_data_sources/register_remote_data_source/register_remote_data_source.dart';
import '../../../models/auth/send_otp_response/send_otp_response.dart';
@Injectable(as: RegisterRepo)
class RegisterRepoImpl implements RegisterRepo {
  final RegisterRemoteDataSource registerRemoteDataSource;
  RegisterRepoImpl({required this.registerRemoteDataSource});
  @override
  Future<Either<Failures, SendOtpResponse>> registerUser({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String role,
  }) {
    return registerRemoteDataSource.register(
      email: email,
      password: password,
      fullName: fullName,
      phone: phone,
      role: role,
    );
  }
  @override
  Future<Either<Failures, AuthUserEntity>> verifyOtp({
    required String email,
    required String otp,
  }){
     return registerRemoteDataSource.verifyOtp(email: email, otp: otp);
  }
}