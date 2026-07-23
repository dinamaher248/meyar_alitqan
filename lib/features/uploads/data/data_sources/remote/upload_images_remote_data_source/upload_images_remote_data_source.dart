
import 'package:either_dart/either.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/upload_result_entity/upload_result_entity.dart';

abstract class UploadImagesRemoteDataSource {
  Future<Either<Failures, UploadResultEntity>> uploadImages(List<XFile> images);
}
