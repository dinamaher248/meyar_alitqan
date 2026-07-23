import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/utils/colors_manager.dart';

import '../../../../../core/helper/responsive_size.dart';

class LanguageItem extends StatelessWidget {
  final String title;
  final String flag;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageItem({
    super.key,
    required this.title,
    required this.flag,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(RS.radius(context, 12)),
      child: Container(
        padding: EdgeInsets.all(RS.size(context, 12)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RS.radius(context, 12)),
          border: Border.all(
            color: isSelected
                ? ColorsManager.primaryColor
                : Colors.grey.shade300,
            width: 1.5,
          ),
          color: isSelected
              ? ColorsManager.primaryColor.withOpacity(0.05)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: RS.radius(context, 18),
              backgroundColor: Colors.transparent,
              child: Image.asset(flag, fit: BoxFit.cover),
            ),
            SizedBox(width: RS.size(context, 12)),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: RS.font(context, 16),
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: ColorsManager.primaryColor
              ),
          ],
        ),
      ),
    );
  }
}
