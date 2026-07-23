import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../enums/order_status.dart';

extension OrderStatusX on OrderStatus {

  /// ================= CURRENT LABEL =================
  String localized(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    switch (this) {
      case OrderStatus.pending:
        return loc.order_status_pending;
      case OrderStatus.assigned:
        return loc.order_status_assigned;
      case OrderStatus.onTheWay:
        return loc.order_status_onTheWay;
      case OrderStatus.arrived:
        return loc.order_status_arrived;
      case OrderStatus.inProgress:
        return loc.order_status_inProgress;
      case OrderStatus.completed:
        return loc.order_status_completed;
      case OrderStatus.canceled:
        return loc.order_status_canceled;
    }
  }

  /// ================= NEXT STATUS =================
  OrderStatus? nextStatus() {
    switch (this) {
      case OrderStatus.pending:
        return OrderStatus.assigned;

      case OrderStatus.assigned:
        return OrderStatus.onTheWay;

      case OrderStatus.onTheWay:
        return OrderStatus.arrived;

      case OrderStatus.arrived:
        return OrderStatus.inProgress;

      case OrderStatus.inProgress:
        return OrderStatus.completed;

      case OrderStatus.completed:
      case OrderStatus.canceled:
        return null; // مفيش حالة بعدها
    }
  }

  /// ================= NEXT STATUS LABEL =================
  String? nextLocalized(BuildContext context) {
    final next = nextStatus();
    if (next == null) return null;
    return next.localized(context);
  }

  /// ================= CAN UPDATE ? =================
  bool get canUpdate =>
      this != OrderStatus.completed &&
          this != OrderStatus.canceled;
}
extension OrderStatusApiX on OrderStatus {
  String toApi() {
    switch (this) {
      case OrderStatus.pending:
        return 'pending';
      case OrderStatus.assigned:
        return 'assigned';
      case OrderStatus.onTheWay:
        return 'on_the_way';
      case OrderStatus.arrived:
        return 'arrived';
      case OrderStatus.inProgress:
        return 'in_progress';
      case OrderStatus.completed:
        return 'completed';
      case OrderStatus.canceled:
        return 'canceled';
    }
  }

}
extension OrderStatusFromApiX on String {
  OrderStatus toOrderStatus() {
    switch (this) {
      case 'pending':
        return OrderStatus.pending;
      case 'assigned':
        return OrderStatus.assigned;
      case 'on_the_way':
        return OrderStatus.onTheWay;
      case 'arrived':
        return OrderStatus.arrived;
      case 'in_progress':
        return OrderStatus.inProgress;
      case 'completed':
        return OrderStatus.completed;
      case 'canceled':
        return OrderStatus.canceled;
      default:
        return OrderStatus.pending;
    }
  }
}
