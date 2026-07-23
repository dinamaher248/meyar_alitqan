abstract class UploadImagesViewModelStates {}

class UploadImagesViewModelInitial extends UploadImagesViewModelStates {}

class UploadImagesViewModelLoading extends UploadImagesViewModelStates {}

class UploadImagesViewModelSuccess extends UploadImagesViewModelStates {
  final List<String> imagePaths;

  UploadImagesViewModelSuccess(this.imagePaths);
}

class UploadImagesViewModelError extends UploadImagesViewModelStates {
  final String error;

  UploadImagesViewModelError(this.error);
}
