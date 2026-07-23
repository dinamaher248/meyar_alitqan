import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/utils/constants_manager.dart';
@singleton
class ApiManager {
  late final Dio _dio;


  ApiManager() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),

        validateStatus: (status) => status != null && status < 500,
        receiveDataWhenStatusError: true,

        headers: {
          'Content-Type': 'application/json',
          'apikey': ConstantsManager.supabaseAnonKey,
        },
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
  }



  Future<Response> get({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    try {
      return await _dio.get(
        url,
        queryParameters: query,
        options: _options(token),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post({
    required String url,
    dynamic body,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    return await _dio.post(
      url,
      data: body,
      queryParameters: query,
      options: _options(token),
    );
  }

  Options _options(String? token, {bool isMultipart = false}) {
    return Options(
      headers: {
        if (token != null) 'Authorization': 'Bearer $token',
        if (isMultipart) 'Content-Type': 'multipart/form-data',
      },
    );
  }
  Future<Response> patch({
    required String url,
    dynamic body,
    String? token,
  }) async {
    try {
      return await _dio.patch(
        url,
        data: body,
        options: _options(token),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception parseError(dynamic data) {
    try {
      if (data is String) {
        final decoded = jsonDecode(data);
        if (decoded is Map && decoded['message'] != null) {
          return Exception(decoded['message']);
        }
      }
    } catch (_) {}

    return Exception(data.toString());
  }

  Future<Response> put({
    required String url,
    dynamic body,
    String? token,
  }) async {
    try {
      return await _dio.put(url, data: body, options: _options(token));
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> delete({
    required String url,
    dynamic body,
    String? token,
  }) async {
    try {
      return await _dio.delete(url, data: body, options: _options(token));
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> upload({
    required String url,
    required List<File> files,
    String fieldName = 'images',
    Map<String, dynamic>? data,
    String? token,
  }) async {
    try {
      final formData = FormData.fromMap({
        ...?data,
        fieldName: [
          for (final file in files) await MultipartFile.fromFile(file.path),
        ],
      });

      return await _dio.post(
        url,
        data: formData,
        options: _options(token, isMultipart: true),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    if (e.response != null) {
      return Exception(
        e.response?.data['message'] ??
            e.response?.data['error'] ??
            'Server Error',
      );
    } else {
      return Exception('No Internet Connection');
    }
  }
}
