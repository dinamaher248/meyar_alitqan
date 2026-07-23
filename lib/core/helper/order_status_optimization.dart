import '../enums/order_status.dart';

bool isCurrentOrder(String status) {
  return [
    OrderStatus.pending.name,
    OrderStatus.assigned.name,
    OrderStatus.onTheWay.name,
    OrderStatus.arrived.name,
    OrderStatus.inProgress.name,
  ].contains(status);
}

bool isPreviousOrder(String status) {
  return [
    OrderStatus.completed.name,
    OrderStatus.canceled.name,
  ].contains(status);
}
