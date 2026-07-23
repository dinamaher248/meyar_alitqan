
import 'package:either_dart/src/either.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import 'package:meayar_alitqan/core/errors/failures.dart';

import 'package:meayar_alitqan/features/uploads/domain/entities/upload_result_entity/upload_result_entity.dart';

import '../../../domain/repositories/upload_images_repo/upload_images_repo.dart';
import '../../data_sources/remote/upload_images_remote_data_source/upload_images_remote_data_source.dart';
@Injectable(as: UploadImagesRepo)
class UploadImagesRepoImpl implements UploadImagesRepo {
  final UploadImagesRemoteDataSource uploadImagesRemoteDataSource;
  UploadImagesRepoImpl(this.uploadImagesRemoteDataSource);
  @override
  Future<Either<Failures, UploadResultEntity>> uploadImages(List<XFile> images) {
   return uploadImagesRemoteDataSource.uploadImages(images);
  }
}