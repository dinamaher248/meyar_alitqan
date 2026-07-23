abstract class UpdateOrderStatusViewModelStates {}
class UpdateOrderStatusViewModelInitial extends UpdateOrderStatusViewModelStates {}
class UpdateOrderStatusViewModelLoading extends UpdateOrderStatusViewModelStates {}
class UpdateOrderStatusViewModelSuccess extends UpdateOrderStatusViewModelStates {

}
class UpdateOrderStatusViewModelError extends UpdateOrderStatusViewModelStates {
  final String message;
  UpdateOrderStatusViewModelError(this.message);
}
