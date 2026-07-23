import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/extensions/order_status.dart';
import '../../../../../core/helper/responsive_size.dart' show RS;
import '../../../../../core/enums/order_status.dart';

class OrderStatusBadge extends StatelessWidget {
  final OrderStatus status;
  final Color color;

  const OrderStatusBadge({
    super.key,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: RS.size(context, 4),
        vertical: RS.size(context, 4),
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(RS.radius(context, 8)),
      ),
      child: Text(
        status.localized(context),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: RS.font(context, 12),
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
