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
  final bool isTechnician;
  const CustomOrdersTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
    this.currentOrdersCount = 0,
    this.previousOrdersCount = 0,
    this.currentOrdersLabel,
    this.previousOrdersLabel,
    this.isTechnician = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(RS.size(context, 4)),
      decoration: BoxDecoration(
        color: ColorsManager.grey.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(RS.radius(context, 12)),
      ),
      child: Row(
        children: [
          _TabItem(
            title: isTechnician
                ? AppLocalizations.of(context)!.newOrders
                : currentOrdersLabel ??
                      AppLocalizations.of(context)!.currentServices,
            isSelected: selectedIndex == 0,
            onTap: () => onTabChanged(0),
          ),
          _TabItem(
            title: isTechnician
                ? AppLocalizations.of(context)!.recentOrders
                : previousOrdersLabel ??
                      AppLocalizations.of(context)!.previousServices,
            isSelected: selectedIndex == 1,
            onTap: () => onTabChanged(1),
          ),
          isTechnician
              ? _TabItem(
                  title: AppLocalizations.of(context)!.oldOrders,
                  isSelected: selectedIndex == 2,
                  onTap: () => onTabChanged(2),
                )
              : SizedBox(),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isSelected
                        ? ColorsManager.primaryTextDarkColor
                        : ColorsManager.darkGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: RS.font(context, 16),
                  ),
                ),
              ),

              SizedBox(height: RS.size(context, 8)),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: RS.size(context, 5),
                width: RS.size(context, 90),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorsManager.primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
