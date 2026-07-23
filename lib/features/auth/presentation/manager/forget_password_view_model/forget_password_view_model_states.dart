abstract class ForgetPasswordViewModelStates {}
class ForgetPasswordViewModelInitial extends ForgetPasswordViewModelStates {}
class ForgetPasswordViewModelLoading extends ForgetPasswordViewModelStates {}
class ForgetPasswordViewModelSuccess extends ForgetPasswordViewModelStates {}
class ForgetPasswordViewModelError extends ForgetPasswordViewModelStates {
  final String message;
  ForgetPasswordViewModelError({required this.message});
}
