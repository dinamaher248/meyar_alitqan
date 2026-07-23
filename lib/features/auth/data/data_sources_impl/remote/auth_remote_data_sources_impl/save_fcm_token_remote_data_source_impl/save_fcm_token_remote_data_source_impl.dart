import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/api/api_manager.dart';

import '../../../../../../../core/api/api_end_points.dart';
import '../../../../../../../core/errors/failures.dart';
import '../../../../../../../core/helper/app_messages.dart';
import '../../../../../../../core/helper/network_validation.dart';
import '../../../../data_sources/remote/auth_remote_data_sources/save_fcm_token_remote_data_source/save_fcm_token_remote_data_source.dart';

@Injectable(as: SaveFcmTokenRemoteDataSource)
class SaveFcmTokenRemoteDataSourceImpl
    implements SaveFcmTokenRemoteDataSource {
  final ApiManager apiManager = ApiManager();

  @override
  Future<Either<Failures, bool>> saveFcmToken({
    required String token,
    required String platform,
  }) async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      final response = await apiManager.post(
        url: ApiEndPoints.saveFcmToken,
        body: {
          'token': token,
          'platform': platform, // android / ios / web
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(true);
      }

      return Left(ServerFailure(response.data.toString()));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

