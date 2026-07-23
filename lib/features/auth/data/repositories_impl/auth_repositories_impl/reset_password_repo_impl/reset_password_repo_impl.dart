import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/repositories/auth_repositories/reset_password_repo/reset_password_repo.dart';
import '../../../data_sources/remote/auth_remote_data_sources/reset_password_remote_data_source/reset_password_remote_data_source.dart';
@Injectable(as: ResetPasswordRepo)
 class ResetPasswordRepoImpl implements ResetPasswordRepo{
   final ResetPasswordRemoteDataSource remoteDataSource;
  ResetPasswordRepoImpl(this.remoteDataSource);
  @override
  Future<Either<Failures, void>> resetPassword({required String newPassword}) {
    return remoteDataSource.resetPassword(newPassword: newPassword);
  }

 }
