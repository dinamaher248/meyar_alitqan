import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../../../../core/helper/responsive_size.dart';
import '../../../../../../core/utils/colors_manager.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: RS.size(context, 16),
        vertical: RS.size(context, 12),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: RS.size(context, 12),
        vertical: RS.size(context, 6),
      ),
      decoration: BoxDecoration(
        color: ColorsManager.primaryColor,
        borderRadius: BorderRadius.circular(RS.radius(context, 30)),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.black.withOpacity(0.15),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: GNav(
          selectedIndex: currentIndex,
          onTabChange: onTap,
          gap: RS.size(context, 8),
          color: ColorsManager.white.withOpacity(0.7),
          activeColor: ColorsManager.secondaryColor,
          iconSize: RS.size(context, 22),
          padding: EdgeInsets.symmetric(
            horizontal: RS.size(context, 16),
            vertical: RS.size(context, 10),
          ),
          tabBackgroundColor: ColorsManager.secondaryColor.withOpacity(0.15),
          tabBorderRadius: RS.radius(context, 20),
          textStyle: TextStyle(
            color: ColorsManager.secondaryColor,
            fontSize: RS.font(context, 13),
            fontWeight: FontWeight.w600,
          ),
          tabs: items.map((item) {
            final isActive = items.indexOf(item) == currentIndex;

            return GButton(
              icon: Icons.circle, // placeholder, overridden by leading
              leading: _buildIcon(context, item, isActive),
              text: item.label,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context, BottomNavItem item, bool active) {
    final icon = active ? item.activeIcon : item.icon;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        SvgPicture.asset(
          icon,
          height: RS.size(context, 22),
          width: RS.size(context, 22),
          color: active
              ? ColorsManager.secondaryColor
              : ColorsManager.white.withOpacity(0.7),
        ),
        if (item.badgeCount > 0)
          Positioned(
            right: -4,
            top: -4,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                item.badgeCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

class BottomNavItem {
  final String label;
  final String icon;
  final String activeIcon;
  final int badgeCount;

  const BottomNavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    this.badgeCount = 0,
  });
}