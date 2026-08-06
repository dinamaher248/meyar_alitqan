import 'package:flutter/material.dart';

import '../enums/order_status.dart';

extension OrderStatusExtension on OrderStatus {
  static IconData icon(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Icons.access_time;

      case OrderStatus.assigned:
        return Icons.person_pin_circle_outlined;

      case OrderStatus.onTheWay:
        return Icons.directions_car_filled_outlined;

      case OrderStatus.arrived:
        return Icons.location_on_outlined;

      case OrderStatus.inProgress:
        return Icons.build_outlined;

      case OrderStatus.completed:
        return Icons.check_circle_outline;

      case OrderStatus.canceled:
        return Icons.cancel_outlined;
    }
  }
}
