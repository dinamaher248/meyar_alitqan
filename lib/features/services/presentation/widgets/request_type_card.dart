import 'package:flutter/material.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';

class RequestTypeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;
final String? badgeText;

  const RequestTypeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
    this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
  onTap: onTap,
  child: Stack(
    children: [
      Container(
        width: RS.size(context, 170),
        margin: EdgeInsets.only(right: RS.size(context, 12)),
        padding: EdgeInsets.all(RS.size(context, 12)),
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(RS.radius(context, 12)),
          border: Border.all(
            color: isSelected ? color : ColorsManager.grey,
            width: RS.size(context, 2),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: RS.size(context, 30), color: color),
            SizedBox(height: RS.size(context, 12)),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: RS.font(context, 15),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: RS.size(context, 6)),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: RS.font(context, 13),
                color: ColorsManager.black.withOpacity(0.6),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      // 👇 Badge
      if (badgeText != null)
        Positioned(
          top: RS.size(context, 2),
          right: RS.size(context, 15),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: RS.size(context, 8),
              vertical: RS.size(context, 4),
            ),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              badgeText!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: RS.font(context, 11),
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
    ],
  ),
);

  }
}
