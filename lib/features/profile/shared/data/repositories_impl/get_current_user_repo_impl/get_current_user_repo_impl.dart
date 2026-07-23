import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../domain/entities/base_profile_entity/base_profile_entity.dart';
import '../../../domain/repositories/get_current_user_repo/get_current_user_repo.dart';
import '../../data_sources/remote/get_current_user_remote_data_source/get_current_user_remote_data_source.dart';
@Injectable(as: GetCurrentUserRepo)
class GetCurrentUserRepoImpl implements GetCurrentUserRepo {
  final GetCurrentUserRemoteDataSource getCurrentUserRemoteDataSource;
  GetCurrentUserRepoImpl({required this.getCurrentUserRemoteDataSource});
  @override
  Future<Either<Failures, BaseProfileEntity>> getCurrentUser({ required String accessToken}) {
    return getCurrentUserRemoteDataSource.getCurrentUser(accessToken: accessToken);
  }
}