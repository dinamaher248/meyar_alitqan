import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/api/api_end_points.dart';
import 'package:meayar_alitqan/core/api/api_manager.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/core/helper/app_messages.dart';
import 'package:meayar_alitqan/core/helper/network_validation.dart';
import '../../../../domain/entities/base_profile_entity/base_profile_entity.dart';
import '../../../models/base_profile_model/base_profile_model.dart';
import '../../../data_sources/remote/get_current_user_remote_data_source/get_current_user_remote_data_source.dart';

@Injectable(as: GetCurrentUserRemoteDataSource)
class GetCurrentUserRemoteDataSourceImpl
    implements GetCurrentUserRemoteDataSource {
  final ApiManager apiManager = ApiManager();

  @override
  Future<Either<Failures, BaseProfileEntity>> getCurrentUser({
    required String accessToken,
  }) async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      final response = await apiManager.get(
        url: ApiEndPoints.getCurrentUser,
        token: accessToken,
      );

      if (response.statusCode == 200) {
        final data = response.data is String
            ? jsonDecode(response.data)
            : response.data;

        final profileJson = data['profile'];

        if (profileJson == null) {
          return Left(ServerFailure('PROFILE_NOT_FOUND'));
        }

        return Right(BaseProfileModel.fromJson(profileJson));
      }


      return Left(ServerFailure(response.data.toString()));
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data?.toString() ?? AppMessages.serverError,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
