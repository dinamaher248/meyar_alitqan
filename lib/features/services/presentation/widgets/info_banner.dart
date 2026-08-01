import 'package:flutter/material.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';

class InfoBanner extends StatelessWidget {
  final String message;
  final Color? backgroundColor;
  final Color? iconColor;

  const InfoBanner({
    super.key,
    required this.message,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color mainColor = iconColor ?? ColorsManager.primaryColor;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: RS.size(context, 14),
        vertical: RS.size(context, 12),
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? mainColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(RS.radius(context, 12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// ===== Info Icon =====
          Container(
            width: RS.size(context, 22),
            height: RS.size(context, 22),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: mainColor,
                width: RS.size(context, 1.5),
              ),
            ),
            child: Text(
              '!',
              style: TextStyle(
                fontSize: RS.font(context, 13),
                fontWeight: FontWeight.bold,
                color: mainColor,
              ),
            ),
          ),
          SizedBox(width: RS.size(context, 10)),

          Expanded(
            child: Text(
              message,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: RS.font(context, 16),
                fontWeight: FontWeight.w500,
                color: mainColor,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
