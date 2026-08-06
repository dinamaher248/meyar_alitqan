import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/extensions/order_status.dart';
import 'package:meayar_alitqan/core/helper/order_status_icon.dart';

import '../../../../../core/enums/order_status.dart';
import '../../../../../core/helper/responsive_size.dart' show RS;

class OrderStatusBadge extends StatelessWidget {
  final OrderStatus status;
  final Color color;
  final IconData icon;


  const OrderStatusBadge({
    super.key,
    required this.status,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: RS.size(context, 8),
        vertical: RS.size(context, 4),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(RS.radius(context, 5)),
      ),
      child: Row(
        children: [

          Icon(
            OrderStatusExtension.icon(status),
            size: RS.size(context, 15),
            color: color,
          ),
          SizedBox(width: RS.size(context, 4)),
          Text(
            status.localized(context),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: RS.font(context, 11),
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
        ],
      ),
    );
  }
}