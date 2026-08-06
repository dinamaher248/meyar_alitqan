import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/helper/responsive_size.dart';
import '../../../../../core/utils/colors_manager.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              width: RS.size(context, 12),
              height: RS.size(context, 12),
              color: ColorsManager.secondaryTextDarkColor,
            ),
            SizedBox(width: RS.size(context, 4)),
            Text(
              label,
              style: TextStyle(
                fontSize: RS.font(context, 11),
                color: ColorsManager.secondaryTextDarkColor,
              ),
            ),
          ],
        ),
        SizedBox(height: RS.size(context, 4)),
        AutoSizeText(
          value,
          maxFontSize: RS.font(context, 12),
          minFontSize: RS.font(context, 8),
          maxLines: 2,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: RS.font(context, 12),
                fontWeight: FontWeight.w600,
                color: ColorsManager.primaryTextDarkColor,
              ),
        ),
      ],
    );
  }
}