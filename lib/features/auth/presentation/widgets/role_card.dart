import 'package:flutter/material.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';

class RoleCard extends StatelessWidget {
  final String icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,

            transform: Matrix4.identity()..scale(isSelected ? 1.08 : 1.0),

            padding: EdgeInsets.all(RS.size(context, 12)),
            decoration: BoxDecoration(
              color: isSelected
                  ? ColorsManager.primaryColor
                  : ColorsManager.white,
              border: Border.all(
                color: isSelected
                    ? ColorsManager.primaryColor
                    : ColorsManager.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(RS.radius(context, 24)),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: ColorsManager.primaryColor.withValues(
                          alpha: 0.4,
                        ),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ]
                  : [],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset(icon)],
            ),
          ),
        ),
        SizedBox(height: RS.size(context, 16)),

        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: ColorsManager.primaryColor,
            fontSize: RS.font(context, 18),
          ),
        ),
      ],
    );
  }
}
