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
  final IconData statusIcon;

  const OrderHeader({
    super.key,
    required this.orderNumber,
    required this.title,
    required this.status,
    required this.statusColor,
    required this.statusIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: RS.font(context, 15),
                fontWeight: FontWeight.bold,
                color: ColorsManager.primaryTextDarkColor,
              ),
            ),
            OrderStatusBadge(status: status, color: statusColor,icon: statusIcon),
          ],
        ),
        SizedBox(height: RS.size(context, 8)),
        OrderNumberBadge(orderNumber: orderNumber),
      ],
    );
  }
}
