import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../core/api/api_end_points.dart';
import '../../../../../../../core/api/api_manager.dart';
import '../../../../../../../core/errors/failures.dart';
import '../../../../../../../core/helper/network_validation.dart';
import '../../../../../../../core/helper/app_messages.dart';
import '../../../../../domain/entities/auth/auth_user_entity/auth_user_entity.dart';
import '../../../../data_sources/remote/auth_remote_data_sources/register_remote_data_source/register_remote_data_source.dart';
import '../../../../models/auth/auth_user_model/auth_user_model.dart';
import '../../../../models/auth/send_otp_response/send_otp_response.dart';

@Injectable(as: RegisterRemoteDataSource)
class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final ApiManager apiManager = ApiManager();

  @override
  Future<Either<Failures, SendOtpResponse>> register({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String role,
  }) async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }
      final session = Supabase.instance.client.auth.currentSession;

      String? fcmToken;
      if (!kIsWeb) {
        fcmToken = await FirebaseMessaging.instance.getToken();
      }

      final response = await apiManager.post(
        url: ApiEndPoints.sendOtp,
        token: session?.accessToken,
        body: {
          'email': email,
          'password': password,
          'fullName': fullName,
          'phone': phone,
          'role': role,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        final Map<String, dynamic> json = data is String
            ? jsonDecode(data)
            : data;

        return  Right(SendOtpResponse.fromJson(json));
      }

      return Left(ServerFailure(response.data.toString()));
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data != null) {
        return Left(ServerFailure(data.toString()));
      }

      return Left(ServerFailure(e.message ?? 'Unknown server error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  @override
  Future<Either<Failures, AuthUserEntity>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      final response = await apiManager.post(
        url: ApiEndPoints.verifyOtp,
        body: {
          'email': email,
          'otp': otp,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        final Map<String, dynamic> json = data is String
            ? jsonDecode(data)
            : data;

        return Right(AuthUserModel.fromRegisterJson(json));
      }

      return Left(ServerFailure(response.data.toString()));
    } on DioException catch (e) {
      return Left(ServerFailure(
          e.response?.data.toString() ?? e.message ?? 'error'));
    }
  }
}
