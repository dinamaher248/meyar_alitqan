 import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:meayar_alitqan/core/errors/failures.dart';

import 'package:meayar_alitqan/features/auth/domain/entities/auth/auth_user_entity/auth_user_entity.dart';

import '../../../../domain/repositories/auth_repositories/google_repo/google_repo.dart';
import '../../../data_sources/remote/auth_remote_data_sources/google_remote_data_source/google_remote_data_source.dart';
@Injectable(as: GoogleRepo)
class GoogleRepoImpl implements GoogleRepo{
  final GoogleRemoteDataSource googleRemoteDataSource;
  GoogleRepoImpl(this.googleRemoteDataSource);
  @override
  Future<Either<Failures, AuthUserEntity>> signInWithGoogle() {
    return googleRemoteDataSource.signInWithGoogle();
  }
}