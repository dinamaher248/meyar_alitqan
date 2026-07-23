abstract class DeleteAccountViewModelStates {}
class DeleteAccountViewModelInitial extends DeleteAccountViewModelStates {}
class DeleteAccountViewModelLoading extends DeleteAccountViewModelStates {}
class DeleteAccountViewModelSuccess extends DeleteAccountViewModelStates {}
class DeleteAccountViewModelError extends DeleteAccountViewModelStates {
  final String message;

  DeleteAccountViewModelError({required this.message});
}