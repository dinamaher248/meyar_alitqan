abstract class   ResetPasswordViewModelStates {}
class ResetPasswordViewModelInitial extends ResetPasswordViewModelStates {}
class ResetPasswordViewModelLoading extends ResetPasswordViewModelStates {}
class ResetPasswordViewModelSuccess extends ResetPasswordViewModelStates {}
class ResetPasswordViewModelError extends ResetPasswordViewModelStates {
  final String message;
  ResetPasswordViewModelError({required this.message});
}
