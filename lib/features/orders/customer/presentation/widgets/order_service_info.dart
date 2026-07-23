import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../../core/helper/responsive_size.dart';
import '../../../../../core/utils/colors_manager.dart';
import '../../../shared/presentation/widgets/order_info_label.dart';
class OrderServiceInfo extends StatelessWidget {
  final String icon;
  final String label;
  final String value;

  const OrderServiceInfo({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(RS.size(context, 8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderInfoLabel(icon: icon, label: label),
          SizedBox(height: RS.size(context, 4)),
          AutoSizeText(
            value,
            maxFontSize: RS.font(context, 14),
            minFontSize: RS.font(context, 8),
            maxLines: 2,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: RS.font(context, 12),
              fontWeight: FontWeight.bold,
              color: ColorsManager.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
