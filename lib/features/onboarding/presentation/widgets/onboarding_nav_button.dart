import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/colors_manager.dart';
import '../../../../core/helper/responsive_size.dart';

class OnboardingNavButton extends StatelessWidget {
  final VoidCallback onTap;
  final String icon;

  const OnboardingNavButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: RS.size(context, 55),
        width: RS.size(context, 55),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: ColorsManager.primaryColor,
        ),
        child: Center(
          child: SvgPicture.asset(
            icon,
            color: ColorsManager.white,
            width: RS.size(context, 22),
            height: RS.size(context, 22),
          ),
        ),
      ),
    );
  }
}
