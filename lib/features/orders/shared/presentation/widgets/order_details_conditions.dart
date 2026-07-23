import 'package:meayar_alitqan/core/enums/order_status.dart';
import '../../domain/entities/order_entity/order_entity.dart';

class OrderDetailsConditions {
  final OrderEntity? order;
  final bool isTechnician;

  OrderDetailsConditions(this.order, this.isTechnician);

  bool get showMedia => !isTechnician;

  bool get showCancel => !isTechnician && order?.status == OrderStatus.pending;

  bool get showCallButton =>
      isTechnician && (order?.customer?.phone?.isNotEmpty ?? false);

  bool get showViewDetails => isTechnician;

  bool get hasTechnician => order?.technician != null && !isTechnician;

  bool get showNoTechnician => order?.technician == null && !isTechnician;

  bool get hasPrice => order?.price != null && (order?.price ?? 0) > 0;

  bool get showLocation =>
      order?.location != null && order!.location.isNotEmpty;

  bool get showUpdateStatus => isTechnician;
}