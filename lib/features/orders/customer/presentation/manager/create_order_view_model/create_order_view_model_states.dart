abstract class CreateOrderViewModelStates {}
class CreateOrderViewModelInitial extends CreateOrderViewModelStates {}
class CreateOrderViewModelLoading extends CreateOrderViewModelStates {}
class CreateOrderViewModelSuccess extends CreateOrderViewModelStates {}
class CreateOrderViewModelError extends CreateOrderViewModelStates {
  final String message;
  CreateOrderViewModelError(this.message);
}
