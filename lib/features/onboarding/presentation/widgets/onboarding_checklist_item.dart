import 'package:flutter/material.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';

class OnboardingChecklistItem extends StatelessWidget {
  const OnboardingChecklistItem({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: RS.size(context, 4)),
      child: Row(
        children: [
          SizedBox(width: RS.size(context, 35)),

          Icon(
            Icons.check,
            color: ColorsManager.primaryColor,
            size: RS.size(context, 18),
          ),
          SizedBox(width: RS.size(context, 8)),

          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: RS.font(context, 14),
                fontWeight: FontWeight.w500,
                color: ColorsManager.primaryTextDarkColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
