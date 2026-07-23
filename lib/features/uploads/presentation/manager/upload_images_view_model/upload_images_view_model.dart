
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import 'upload_images_view_model_states.dart';
import '../../../domain/use_cases/upload_images_use_case/upload_images_use_case.dart';

@injectable
class UploadImagesViewModel extends Cubit<UploadImagesViewModelStates> {
  final UploadImagesUseCase uploadImagesUseCase;

  UploadImagesViewModel(this.uploadImagesUseCase)
      : super(UploadImagesViewModelInitial());

 
  Future<void> uploadImages(List<XFile> images) async {
    emit(UploadImagesViewModelLoading());

    try {
      final result = await uploadImagesUseCase.uploadImages(
        images: images,
        isWeb: kIsWeb,
      );

      result.fold(
        (failure) => emit(UploadImagesViewModelError(failure.message)),
        (uploadResultEntity) {
          emit(
            UploadImagesViewModelSuccess(uploadResultEntity.path),
          );
        },
      );
    } catch (e) {
      emit(UploadImagesViewModelError(e.toString()));
    }
  }
}
