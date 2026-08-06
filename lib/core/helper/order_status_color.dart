import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/utils/colors_manager.dart';
import '../enums/order_status.dart';

class OrderStatusColor {
  static Color fromStatus(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return ColorsManager.secondaryColor;

      case OrderStatus.assigned:
        return ColorsManager.secondaryColor;

      case OrderStatus.onTheWay:
        return ColorsManager.secondaryColor;

      case OrderStatus.arrived:
        return ColorsManager.secondaryColor;

      case OrderStatus.inProgress:
        return ColorsManager.inProgressColor;

      case OrderStatus.completed:
        return Colors.green;

      case OrderStatus.canceled:
        return Colors.red;
    }
  }
}
