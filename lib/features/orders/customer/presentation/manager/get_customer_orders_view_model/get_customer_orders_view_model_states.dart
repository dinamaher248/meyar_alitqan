import '../../../../shared/domain/entities/order_entity/order_entity.dart';

abstract class GetCustomerOrdersViewModelStates {}
class GetCustomerOrdersViewModelInitial extends GetCustomerOrdersViewModelStates {}
class GetCustomerOrdersViewModelLoading extends GetCustomerOrdersViewModelStates {}
class GetCustomerOrdersViewModelSuccess extends GetCustomerOrdersViewModelStates {
  final List<OrderEntity> orders;
  GetCustomerOrdersViewModelSuccess(this.orders);
}
class GetCustomerOrdersViewModelError extends GetCustomerOrdersViewModelStates {
  final String message;
  GetCustomerOrdersViewModelError(this.message);
}
