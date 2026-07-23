import 'package:flutter/material.dart';

import '../../../../../../../../core/helper/responsive_size.dart';
import '../../../../../../../../core/utils/colors_manager.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class CustomOrdersTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChanged;
  final int? currentOrdersCount;
  final int? previousOrdersCount;
  final String? currentOrdersLabel;
  final String? previousOrdersLabel;

  const CustomOrdersTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
    this.currentOrdersCount = 0,
    this.previousOrdersCount = 0,
    this.currentOrdersLabel,
    this.previousOrdersLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(RS.size(context, 4)),
      decoration: BoxDecoration(
        color: ColorsManager.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(RS.radius(context, 12)),
      ),
      child: Row(
        children: [
          _TabItem(
            title:
                currentOrdersLabel ??
                AppLocalizations.of(context)!.currentServices,
            isSelected: selectedIndex == 0,
            onTap: () => onTabChanged(0),
          ),
          _TabItem(
            title:
                previousOrdersLabel ??
                AppLocalizations.of(context)!.previousServices,
            isSelected: selectedIndex == 1,
            onTap: () => onTabChanged(1),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: EdgeInsets.symmetric(vertical: RS.size(context, 12)),
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorsManager.grey,
              width: RS.size(context, 2),
            ),
            color: isSelected ? ColorsManager.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(RS.radius(context, 12)),
          ),
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: isSelected
                    ? Colors.white
                    : ColorsManager.black.withOpacity(0.6),
                fontWeight: FontWeight.bold,
                fontSize: RS.font(context, 14),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
