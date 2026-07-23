import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/auth/auth_user_entity/auth_user_entity.dart';
import '../../../../domain/repositories/auth_repositories/login_repo/login_repo.dart';
import '../../../data_sources/remote/auth_remote_data_sources/login_remote_data_source/login_remote_data_source.dart';
@Injectable(as: LoginRepo)
class LoginRepoImpl implements LoginRepo {
  final LoginRemoteDataSource loginRemoteDataSource;
  LoginRepoImpl({required this.loginRemoteDataSource});
  @override


  @override
  Future<Either<Failures, AuthUserEntity>> loginUser({required String email, required String password}) {
    return loginRemoteDataSource.login(email: email, password: password);
  }
}