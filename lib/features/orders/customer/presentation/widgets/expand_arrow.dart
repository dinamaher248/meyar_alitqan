import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/helper/responsive_size.dart';
import '../../../../../core/utils/assets_manager.dart';
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
        padding: const EdgeInsets.only(bottom: 8.0),
        child: AnimatedRotation(
          turns: isExpanded ? 0.5 : 0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Container(
            padding: EdgeInsets.all(RS.size(context, 6)),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorsManager.primaryColor,
                width: RS.size(context, 2),
              ),
            ),
            child: SvgPicture.asset(
              AssetsManager.arrowDown,
              width: RS.size(context, 20),
              height: RS.size(context, 20),
            ),
          ),
        ),
      ),
    );
  }
}
