import 'package:flutter/material.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';

class OrderSummaryPricingCard extends StatelessWidget {
  const OrderSummaryPricingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(RS.size(context, 16)),
      decoration: BoxDecoration(
        color: ColorsManager.primaryColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(RS.radius(context, 12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc.costSummary,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: RS.font(context, 14),
              fontWeight: FontWeight.w500,
              color: ColorsManager.darkGrey,
            ),
          ),
          SizedBox(height: RS.size(context, 12)),

          _row(context, loc.servicePrice, "200-400 ${loc.currencyDinar}"),
          SizedBox(height: RS.size(context, 8)),
          _row(context, loc.urgentOrderFee, "100-200 ${loc.currencyDinar}"),

          Padding(
            padding: EdgeInsets.symmetric(vertical: RS.size(context, 10)),
            child: Divider(color: ColorsManager.grey),
          ),

          _row(context, loc.expectedTotal, "300-600 ${loc.currencyDinar}", isTotal: true),
        ],
      ),
    );
  }

  Widget _row(
    BuildContext context,
    String label,
    String value, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: ColorsManager.primaryTextDarkColor,
            fontSize: RS.font(context, 16),
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: RS.font(context, isTotal ? 16 : 13),
            fontWeight: FontWeight.w700,
            color: isTotal
                ? ColorsManager.secondaryColor
                : ColorsManager.primaryTextDarkColor,
          ),
        ),
      ],
    );
  }
}
