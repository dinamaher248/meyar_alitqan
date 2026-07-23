import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/enums/order_status.dart';
import 'package:meayar_alitqan/core/extensions/order_status.dart';
import 'package:meayar_alitqan/core/helper/responsive_size.dart';
import 'package:meayar_alitqan/core/utils/colors_manager.dart';

class OrderDetailsHeader extends StatelessWidget {
  final String orderNumber;
  final String publicDetails;
  final OrderStatus status;
  final Color statusColor;

  const OrderDetailsHeader({
    super.key,
    required this.orderNumber,
    required this.publicDetails,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: RS.size(context, 16),
        vertical: RS.size(context, 12),
      ),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(RS.radius(context, 10)),
          topRight: Radius.circular(RS.radius(context, 10)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOrderNumber(context),
                SizedBox(height: RS.size(context, 4)),
                _buildPublicDetails(context),
              ],
            ),
          ),
          SizedBox(width: RS.size(context, 8)),
          _buildStatusBadge(context),
        ],
      ),
    );
  }

  Widget _buildOrderNumber(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.receipt_long,
          size: RS.size(context, 16),
          color: ColorsManager.primaryColor,
        ),
        SizedBox(width: RS.size(context, 4)),
        Text(
          '#$orderNumber',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: RS.font(context, 14),
            fontWeight: FontWeight.bold,
            color: ColorsManager.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildPublicDetails(BuildContext context) {
    return Text(
      publicDetails,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontSize: RS.font(context, 12),
        color: ColorsManager.grey,
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: RS.size(context, 8),
        vertical: RS.size(context, 4),
      ),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(RS.radius(context, 20)),
      ),
      child: Text(
        status.localized(context),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          fontSize: RS.font(context, 10),
          color: ColorsManager.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}