import 'package:flutter/material.dart';

import '../../../../../../core/enums/web_home_tabs.dart';
import '../../../../../../core/utils/colors_manager.dart';

class CustomerWebTabs extends StatelessWidget {
  final List<MapEntry<WebHomeTab, String>> tabs;
  final WebHomeTab currentTab;
  final ValueChanged<WebHomeTab> onSelect;

  const CustomerWebTabs({
    super.key,
    required this.tabs,
    required this.currentTab,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: tabs.map((entry) {
        final isActive = entry.key == currentTab;

        return Padding(
          padding: const EdgeInsets.only(right: 32),
          child: InkWell(
            onTap: () => onSelect(entry.key),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  entry.value,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight:
                        isActive ? FontWeight.bold : FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: 3,
                  width: isActive ? 40 : 0,
                  decoration: BoxDecoration(
                    color: ColorsManager.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
