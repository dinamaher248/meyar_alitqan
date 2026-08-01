import 'package:flutter/material.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';

class OrderSummaryPricingCard extends StatelessWidget {
  const OrderSummaryPricingCard({super.key});

  @override
  Widget build(BuildContext context) {
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
            "ملخص التكلفة",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: RS.font(context, 14),
              fontWeight: FontWeight.w500,
              color: ColorsManager.darkGrey,
            ),
          ),
          SizedBox(height: RS.size(context, 12)),

          _row(context, "سعر الخدمة", "200-400 دينار"),
          SizedBox(height: RS.size(context, 8)),
          _row(context, "رسوم الطلب العاجل", "100-200 دينار"),

          Padding(
            padding: EdgeInsets.symmetric(vertical: RS.size(context, 10)),
            child: Divider(color: ColorsManager.grey),
          ),

          _row(context, "الإجمالي المتوقع", "300-600 دينار", isTotal: true),
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
