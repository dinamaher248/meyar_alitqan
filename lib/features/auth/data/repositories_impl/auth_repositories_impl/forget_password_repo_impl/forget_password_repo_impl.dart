import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/repositories/auth_repositories/forget_password_repo/forget_password_repo.dart';
import '../../../data_sources/remote/auth_remote_data_sources/forget_password_remote_data_source/forget_password_remote_data_source.dart';
@Injectable(as: ForgetPasswordRepo)
class ForgetPasswordRepoImpl implements ForgetPasswordRepo {
  final ForgetPasswordRemoteDataSource remoteDataSource;
  ForgetPasswordRepoImpl(this.remoteDataSource);
  @override
  Future<Either<Failures, void>> sendResetLink(String email) {
    return remoteDataSource.sendResetLink(email);
  }
}