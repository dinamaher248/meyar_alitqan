import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/helper/responsive_size.dart';
import '../../../../../core/utils/colors_manager.dart';

class OrderInfoLabel extends StatelessWidget {
  final String icon;
  final String label;

  const OrderInfoLabel({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          width: RS.size(context, 12),
        ),
        SizedBox(width: RS.size(context, 6)),

        Expanded(
          child: AutoSizeText(
            label,
            maxFontSize: RS.font(context, 13),
            minFontSize: RS.font(context, 8),
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorsManager.black.withOpacity(0.3),
            ),
          ),
        ),
      ],
    );
  }
}
