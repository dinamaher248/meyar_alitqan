import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meayar_alitqan/core/api/api_end_points.dart';
import 'package:meayar_alitqan/core/api/api_manager.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/core/helper/app_messages.dart';
import 'package:meayar_alitqan/core/helper/network_validation.dart';
import 'package:meayar_alitqan/features/auth/data/models/auth/auth_user_model/auth_user_model.dart';
import 'package:meayar_alitqan/features/auth/domain/entities/auth/auth_user_entity/auth_user_entity.dart';

import '../../../../data_sources/remote/auth_remote_data_sources/login_remote_data_source/login_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart';

@Injectable(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final ApiManager apiManager = ApiManager();

  @override
  Future<Either<Failures, AuthUserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      String? fcmToken;

      if (!kIsWeb) {
        fcmToken = await FirebaseMessaging.instance.getToken();
      }

      final response = await apiManager.post(
        url: ApiEndPoints.login,
        body: {
          'email': email,
          'password': password,
          'fcm_token': fcmToken,
          'platform': kIsWeb ? 'web' : 'android',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data is String
            ? jsonDecode(response.data)
            : response.data;

        return Right(
          AuthUserModel.fromLoginJson(Map<String, dynamic>.from(data)),
        );
      }

      return Left(ServerFailure(response.data.toString()));
    } on DioException catch (e) {
      final data = e.response?.data;
      if (data != null) {
        return Left(ServerFailure(data.toString()));
      }
      return Left(ServerFailure(e.message ?? AppMessages.serverError));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
