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
  final bool isTechnician;

  const OrderHeader({
    super.key,
    required this.isTechnician,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: RS.font(context, 15),
                  fontWeight: FontWeight.bold,
                  color: isTechnician
                      ? ColorsManager.white
                      : ColorsManager.primaryTextDarkColor,
                ),
              ),
            ),
            SizedBox(width: RS.size(context, 8)),
            OrderStatusBadge(
              status: status,
              color: statusColor,
              icon: statusIcon,
            ),
          ],
        ),
        SizedBox(height: RS.size(context, 8)),
        OrderNumberBadge(orderNumber: orderNumber, isTechnician: isTechnician),
      ],
    );
  }
}