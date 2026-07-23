import 'dart:io';
import 'dart:typed_data';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/upload_result_entity/upload_result_entity.dart';
import '../../repositories/upload_video_repo/upload_video_repo.dart';

@injectable
class UploadVideoUseCase {
  final UploadVideoRepo uploadVideoRepo;

  UploadVideoUseCase(this.uploadVideoRepo);

 Future<Either<Failures, UploadResultEntity>> uploadVideoMobile(
  File video, {
  required Function(double) onProgress,
}){

  return uploadVideoRepo.uploadVideoMobile(video, onProgress: onProgress);


}

Future<Either<Failures, UploadResultEntity>> uploadVideoWeb(
  Uint8List bytes, {
  required Function(double) onProgress,
}){

  return uploadVideoRepo.uploadVideoWeb(bytes, onProgress: onProgress);
}

}
