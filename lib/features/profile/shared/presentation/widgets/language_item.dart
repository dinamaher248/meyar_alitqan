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
      borderRadius: BorderRadius.circular(RS.radius(context, 10)),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: RS.size(context, 15),
          vertical: RS.size(context, 15),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RS.radius(context, 10)),
          border: Border.all(
            color: isSelected
                ? ColorsManager.primaryColor
                : Colors.grey.shade300,
            width: 2.2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: RS.size(context, 60),
              height: RS.size(context, 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(RS.radius(context, 8)),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1.5,
                ),
              ),
              child: Image.asset(
                flag,
                width: RS.size(context, 60),
                height: RS.size(context, 50),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: RS.size(context, 10)),

            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: RS.font(context, 18),
                ),
              ),
            ),

            if (isSelected)
              Icon(
                Icons.check_circle,
                color: ColorsManager.primaryColor,
                size: RS.size(context, 30),
              )
            else
              Icon(
                Icons.circle_outlined,
                color: ColorsManager.darkGrey.withValues(alpha: 0.7),
                size: RS.size(context, 30),
              ),
          ],
        ),
      ),
    );
  }
}
