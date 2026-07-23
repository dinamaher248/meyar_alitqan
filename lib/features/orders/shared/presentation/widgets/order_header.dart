import 'package:flutter/material.dart';

import '../../../../../core/enums/order_status.dart';
import '../../../../../core/helper/responsive_size.dart';
import '../../../../../core/utils/colors_manager.dart';
import '../../../customer/presentation/widgets/order_number_badge.dart';
import '../../../customer/presentation/widgets/order_status_badge.dart';

class OrderHeader extends StatelessWidget {
  final String orderNumber;
  final String title;
  final OrderStatus status;
  final Color statusColor;

  const OrderHeader({super.key, 
    required this.orderNumber,
    required this.title,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OrderNumberBadge(orderNumber: orderNumber),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: RS.font(context, 14),
            fontWeight: FontWeight.bold,
            color: ColorsManager.primaryColor,
          ),
        ),
        OrderStatusBadge(
          status: status,
          color: statusColor,
        ),
      ],
    );
  }
}
