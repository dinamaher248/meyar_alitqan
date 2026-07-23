import 'dart:io';
import 'dart:typed_data';

import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/uploads/data/data_sources/remote/upload_video_remote_data_source/upload_video_remote_data_source.dart';

import 'package:meayar_alitqan/features/uploads/domain/entities/upload_result_entity/upload_result_entity.dart';

import '../../../domain/repositories/upload_video_repo/upload_video_repo.dart';

@Injectable(as: UploadVideoRepo)
class UploadVideoRepoImpl implements UploadVideoRepo {
  final UploadVideoRemoteDataSource uploadVideoRemoteDataSource;

  UploadVideoRepoImpl(this.uploadVideoRemoteDataSource);

  @override
  Future<Either<Failures, UploadResultEntity>> uploadVideoMobile(File video, {required Function(double p1) onProgress}) {
    return uploadVideoRemoteDataSource.uploadVideoMobile(video, onProgress: onProgress);
  }

  @override
  Future<Either<Failures, UploadResultEntity>> uploadVideoWeb(Uint8List bytes, {required Function(double p1) onProgress}) {
    return uploadVideoRemoteDataSource.uploadVideoWeb(bytes, onProgress: onProgress);
  }

   
}
