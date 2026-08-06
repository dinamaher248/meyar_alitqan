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
    );
  }
}