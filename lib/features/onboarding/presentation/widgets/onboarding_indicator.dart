import 'package:flutter/material.dart';

import '../../../../../core/utils/colors_manager.dart';
import '../../../../core/helper/responsive_size.dart';

class OnboardingIndicator extends StatelessWidget {
  final int index;
  final int currentIndex;

  const OnboardingIndicator({
    super.key,
    required this.index,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == currentIndex;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: RS.size(context, 8),
      width: RS.size(context, 8),
      margin: EdgeInsets.symmetric(horizontal: RS.size(context, 4)),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? ColorsManager.primaryColor : Colors.transparent,
        border: Border.all(color: ColorsManager.primaryColor, width: 1.2),
      ),
    );
  }
}