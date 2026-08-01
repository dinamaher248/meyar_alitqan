import 'package:flutter/material.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';

class RequestTypeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
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
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: RS.size(context, 12)),
        padding: EdgeInsets.all(RS.size(context, 14)),
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(RS.radius(context, 12)),
          border: Border.all(
            color: isSelected ? color : ColorsManager.grey,
            width: RS.size(context, isSelected ? 1.8 : 1),
          ),
        ),
        child: Row(
          children: [
            /// ===== Icon =====
            Container(
              width: RS.size(context, 90),
              height: RS.size(context, 100),
              decoration: BoxDecoration(color: color.withValues(alpha: 0.12)),
              child: Image.asset(
                icon,
                width: RS.size(context, 50),
                height: RS.size(context, 50),
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(width: RS.size(context, 4)),

            /// ===== Title + Subtitle =====
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontSize: RS.font(context, 20),
                              fontWeight: FontWeight.w600,
                              color: ColorsManager.primaryTextDarkColor,
                            ),
                      ),
                      if (badgeText != null) ...[
                        SizedBox(width: RS.size(context, 8)),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: RS.size(context, 8),
                            vertical: RS.size(context, 2),
                          ),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            badgeText!,
                            style: TextStyle(
                              fontSize: RS.font(context, 10),
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: RS.size(context, 4)),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: RS.font(context, 16),
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.darkGrey,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: RS.size(context, 8)),
          ],
        ),
      ),
    );
  }
}
