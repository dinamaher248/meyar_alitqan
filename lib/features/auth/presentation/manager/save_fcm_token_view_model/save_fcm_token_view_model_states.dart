abstract class SaveFcmTokenViewModelStates {}

class SaveFcmTokenViewModelInitial extends SaveFcmTokenViewModelStates {}

class SaveFcmTokenViewModelLoading extends SaveFcmTokenViewModelStates {}

class SaveFcmTokenViewModelSuccess extends SaveFcmTokenViewModelStates {}

class SaveFcmTokenViewModelError extends SaveFcmTokenViewModelStates {
  final String message;
  SaveFcmTokenViewModelError({required this.message});
}
