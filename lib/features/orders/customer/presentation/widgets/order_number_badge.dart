import 'package:flutter/material.dart';

import '../../../../../core/helper/responsive_size.dart';
import '../../../../../core/utils/colors_manager.dart';

class OrderNumberBadge extends StatelessWidget {
  final String orderNumber;

  const OrderNumberBadge({super.key, required this.orderNumber});

  @override
  Widget build(BuildContext context) {
    return Text(
      "#1220-129-$orderNumber",
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: RS.font(context, 14),
            fontWeight: FontWeight.w400,
            color: ColorsManager.darkGrey,
          ),
    );
  }
}