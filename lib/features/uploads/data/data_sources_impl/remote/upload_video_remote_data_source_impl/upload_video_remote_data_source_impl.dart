import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../core/api/api_end_points.dart';
import '../../../../../../core/api/api_manager.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/helper/sanitize_file_name.dart';
import '../../../../domain/entities/upload_result_entity/upload_result_entity.dart';
import '../../../data_sources/remote/upload_video_remote_data_source/upload_video_remote_data_source.dart';

@Injectable(as: UploadVideoRemoteDataSource)
class UploadVideoRemoteDataSourceImpl
    implements UploadVideoRemoteDataSource {
  final ApiManager apiManager;

  UploadVideoRemoteDataSourceImpl(this.apiManager);

  // ===================================================
  // 📱 MOBILE
  // ===================================================
  @override
  Future<Either<Failures, UploadResultEntity>> uploadVideoMobile(
    File video, {
    required void Function(double progress) onProgress,
  }) async {
    try {
      final mimeType = lookupMimeType(video.path) ?? 'video/mp4';
      final bytes = await video.readAsBytes();

      return _uploadBytes(
        bytes: bytes,
        mimeType: mimeType,
        originalName: video.path.split('/').last,
        onProgress: onProgress,
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ===================================================
  // 🌐 WEB
  // ===================================================
  @override
  Future<Either<Failures, UploadResultEntity>> uploadVideoWeb(
    Uint8List bytes, {
    required void Function(double progress) onProgress,
  }) async {
    try {
      return _uploadBytes(
        bytes: bytes,
        mimeType: 'video/mp4',
        originalName:
            'web_video_${DateTime.now().millisecondsSinceEpoch}.mp4',
        onProgress: onProgress,
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ===================================================
  // 🔁 SHARED LOGIC
  // ===================================================
  Future<Either<Failures, UploadResultEntity>> _uploadBytes({
    required Uint8List bytes,
    required String mimeType,
    required String originalName,
    required void Function(double progress) onProgress,
  }) async {
    final session = Supabase.instance.client.auth.currentSession;
    final accessToken = session?.accessToken;

    if (accessToken == null) {
      return Left(ServerFailure("User not authenticated"));
    }

    /// sanitize file name
    final safeName =
        '${DateTime.now().millisecondsSinceEpoch}_${sanitizeFileName(originalName)}';

    /// 1️⃣ get signed upload url
    final response = await apiManager.post(
      url: ApiEndPoints.createVideoUploadUrl,
      body: {
        "file_name": safeName,
        "content_type": mimeType,
      },
      token: accessToken,
    );

    final uploadUrl = response.data['uploadUrl'];
    final path = response.data['path'];

    if (uploadUrl == null || path == null) {
      return Left(ServerFailure("Invalid upload response"));
    }

    /// 2️⃣ upload with progress
    final dio = Dio(
      BaseOptions(
        headers: {
          "Content-Type": mimeType,
          "Content-Length": bytes.length.toString(),
        },
      ),
    );

    await dio.put(
      uploadUrl,
      data: bytes,
      onSendProgress: (sent, total) {
        if (total > 0) {
          onProgress(sent / total);
        }
      },
    );

    return Right(
      UploadResultEntity(
        path: [path],
        type: "video",
      ),
    );
  }

 
}
