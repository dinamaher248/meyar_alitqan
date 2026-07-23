import 'package:flutter/material.dart';
import '../enums/order_status.dart';

class OrderStatusColor {
  static Color fromStatus(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.grey;

      case OrderStatus.assigned:
        return Colors.blueGrey;

      case OrderStatus.onTheWay:
        return Colors.orange;

      case OrderStatus.arrived:
        return Colors.deepOrange;

      case OrderStatus.inProgress:
        return Colors.blue;

      case OrderStatus.completed:
        return Colors.green;

      case OrderStatus.canceled:
        return Colors.red;
    }
  }
}
