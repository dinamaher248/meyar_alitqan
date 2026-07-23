
import 'package:either_dart/either.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/upload_result_entity/upload_result_entity.dart';

abstract class UploadImagesRepo {
  Future<Either<Failures, UploadResultEntity>> uploadImages(List<XFile> images);
}
