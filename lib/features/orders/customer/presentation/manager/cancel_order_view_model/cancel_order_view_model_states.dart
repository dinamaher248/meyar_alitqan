abstract class CancelOrderViewModelStates {}
class CancelOrderViewModelInitial extends CancelOrderViewModelStates {}
class CancelOrderViewModelLoading extends CancelOrderViewModelStates {}
class CancelOrderViewModelSuccess extends CancelOrderViewModelStates {}
class CancelOrderViewModelError extends CancelOrderViewModelStates {
  final String message;
  CancelOrderViewModelError(this.message);
}