import 'package:flutter/material.dart';

import '../../../../../core/helper/responsive_size.dart';
import '../../../../../core/utils/colors_manager.dart';

class ExpandArrow extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onTap;

  const ExpandArrow({super.key, required this.isExpanded, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: RS.size(context, 4)),
        child: AnimatedRotation(
          turns: isExpanded ? 0.5 : 0,
          duration: const Duration(milliseconds: 200),
          child: Icon(
            Icons.keyboard_arrow_down,
            color: ColorsManager.secondaryTextDarkColor,
            size: RS.size(context, 20),
          ),
        ),
      ),
    );
  }
}