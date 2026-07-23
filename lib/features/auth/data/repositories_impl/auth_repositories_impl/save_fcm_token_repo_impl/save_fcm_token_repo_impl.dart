import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/auth/data/data_sources/remote/auth_remote_data_sources/save_fcm_token_remote_data_source/save_fcm_token_remote_data_source.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/repositories/auth_repositories/save_fcm_token_repo/save_fcm_token_repo.dart';
@Injectable(as: SaveFcmTokenRepo)
class SaveFcmTokenRepoImpl implements SaveFcmTokenRepo {
  final SaveFcmTokenRemoteDataSource saveFcmTokenRemoteDataSource ;
  SaveFcmTokenRepoImpl(this.saveFcmTokenRemoteDataSource);
  @override
  Future<Either<Failures, bool>>  saveFcmToken({
    required String token,
    required String platform,
  }) {
    return saveFcmTokenRemoteDataSource.saveFcmToken(token: token, platform: platform);
  }
}