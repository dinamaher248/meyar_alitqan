import 'package:either_dart/src/either.dart';

import 'package:meayar_alitqan/core/errors/failures.dart';

import 'package:meayar_alitqan/features/auth/domain/entities/auth/auth_user_entity/auth_user_entity.dart';

import '../../../../domain/repositories/auth_repositories/logout_repo/logout_repo.dart';
import '../../../data_sources/remote/auth_remote_data_sources/logout_remote_data_source/logout_remote_data_source.dart';

class LogoutRepoImpl implements LogoutRepo {
  final LogoutRemoteDataSource logoutRemoteDataSource;
  LogoutRepoImpl({required this.logoutRemoteDataSource});
  @override
  Future<Either<Failures, AuthUserEntity>> logoutUser() {
    return logoutRemoteDataSource.logout();
  }

}