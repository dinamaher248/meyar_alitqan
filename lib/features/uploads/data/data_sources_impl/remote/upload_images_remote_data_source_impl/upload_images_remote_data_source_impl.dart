import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../core/api/api_end_points.dart';
import '../../../../../../core/api/api_manager.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/upload_result_entity/upload_result_entity.dart';
import '../../../data_sources/remote/upload_images_remote_data_source/upload_images_remote_data_source.dart';
@Injectable(as: UploadImagesRemoteDataSource)
class UploadImagesRemoteDataSourceImpl
    implements UploadImagesRemoteDataSource {

  final ApiManager apiManager;
  final Dio dio;

  UploadImagesRemoteDataSourceImpl(this.apiManager, this.dio);

  @override
  Future<Either<Failures, UploadResultEntity>> uploadImages(
      List<XFile> images,
      ) async {
    try {
      final session = Supabase.instance.client.auth.currentSession;
      final accessToken = session?.accessToken;

      if (accessToken == null) {
        return Left(ServerFailure("Unauthorized"));
      }

      final files = await Future.wait(
        images.map((image) async {
          final bytes = await image.readAsBytes();
          return {
            "name": image.path.split('/').last,
            "data": base64Encode(bytes),
            "contentType": lookupMimeType(image.path) ?? "image/jpeg",
          };
        }),
      );

      final response = await apiManager.post(
        url: ApiEndPoints.uploadImages,
        body: {
          "files": files,
        },
        token: accessToken,
      );

      final results = response.data["results"] as List;

      final paths = results
          .where((e) => e["url"] != null)
          .map<String>((e) => e["url"] as String)
          .toList();

      return Right(
        UploadResultEntity(
          path: paths,
          type: "image",
        ),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

}
