
import 'package:either_dart/either.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/upload_result_entity/upload_result_entity.dart';
import '../../repositories/upload_images_repo/upload_images_repo.dart';
@injectable
 class UploadImagesUseCase {
   final UploadImagesRepo uploadImagesRepo;
   UploadImagesUseCase(this.uploadImagesRepo);
   Future<Either<Failures, UploadResultEntity>> uploadImages({
  required List<XFile> images,
  required bool isWeb,
}) {
     return uploadImagesRepo.uploadImages(
       images,
    
     );
   }

 }