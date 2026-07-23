import '../../../../shared/domain/entities/order_entity/order_entity.dart';

abstract class GetTechnicianOrdersViewModelStates {}
class GetTechnicianOrdersViewModelInitial extends GetTechnicianOrdersViewModelStates {}
class GetTechnicianOrdersViewModelLoading extends GetTechnicianOrdersViewModelStates {}
class GetTechnicianOrdersViewModelSuccess extends GetTechnicianOrdersViewModelStates {
  final List<OrderEntity> orders;
  GetTechnicianOrdersViewModelSuccess(this.orders);
}
class GetTechnicianOrdersViewModelError extends GetTechnicianOrdersViewModelStates {
  final String message;
  GetTechnicianOrdersViewModelError(this.message);
}
