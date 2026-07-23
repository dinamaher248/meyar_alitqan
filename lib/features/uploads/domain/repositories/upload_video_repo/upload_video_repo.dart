import 'dart:io';
import 'dart:typed_data';

import 'package:either_dart/either.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/upload_result_entity/upload_result_entity.dart';

abstract class UploadVideoRepo {
Future<Either<Failures, UploadResultEntity>> uploadVideoMobile(
  File video, {
  required Function(double) onProgress,
});

Future<Either<Failures, UploadResultEntity>> uploadVideoWeb(
  Uint8List bytes, {
  required Function(double) onProgress,
});

}