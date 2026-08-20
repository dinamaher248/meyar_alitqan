import 'package:flutter/material.dart';

import '../../../../../../../../core/enums/order_status.dart';
import '../../../../../../../../core/helper/responsive_size.dart';
import '../../../../../../../../core/utils/colors_manager.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../../orders/shared/domain/entities/order_entity/order_entity.dart';

class TechnicianTodaySummarySection extends StatelessWidget {
  const TechnicianTodaySummarySection({super.key, required this.orders});

  final List<OrderEntity> orders;

  int get _completedCount =>
      orders.where((o) => o.status == OrderStatus.completed).length;

  int get _todayOrdersCount {
    final now = DateTime.now();
    return orders.where((o) {
      final d = o.createdAt.toLocal();
      return d.year == now.year && d.month == now.month && d.day == now.day;
    }).length;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.todaySummary,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: RS.font(context, 16),
            color: ColorsManager.primaryTextDarkColor,
          ),
        ),
        SizedBox(height: RS.size(context, 12)),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.attach_money,
                iconColor: ColorsManager.primaryColor,
                label: loc.profitLabel,
                value: "0",
              ),
            ),
            SizedBox(width: RS.size(context, 10)),
            Expanded(
              child: _StatCard(
                icon: Icons.calendar_today,
                iconColor: Colors.amber.shade700,
                label: loc.todayOrdersLabel,
                value: _todayOrdersCount.toString(),
              ),
            ),
            SizedBox(width: RS.size(context, 10)),
            Expanded(
              child: _StatCard(
                icon: Icons.check_circle,
                iconColor: Colors.green,
                label: loc.completedLabel,
                value: _completedCount.toString(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: RS.size(context, 10),
        vertical: RS.size(context, 12),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(RS.radius(context, 12)),
        border: Border.all(color: ColorsManager.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(RS.size(context, 4)),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: RS.size(context, 17 ), color: iconColor),
              ),
              SizedBox(width: RS.size(context, 6)),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: RS.font(context, 14),
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.darkGrey,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: RS.size(context, 8)),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: RS.font(context, 20),
              fontWeight: FontWeight.bold,
              color: ColorsManager.primaryTextDarkColor,
            ),
          ),
        ],
      ),
    );
  }
}
