import 'package:flutter/material.dart';

import '../../../../../../core/enums/web_home_tabs.dart';

class CustomerWebMobileMenu extends StatelessWidget {
  final List<MapEntry<WebHomeTab, String>> tabs;
  final ValueChanged<WebHomeTab> onSelect;

  const CustomerWebMobileMenu({
    super.key,
    required this.tabs,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<WebHomeTab>(
      icon: const Icon(Icons.menu, color: Colors.white),
      onSelected: onSelect,
      itemBuilder: (_) {
        return tabs
            .map(
              (entry) => PopupMenuItem<WebHomeTab>(
                value: entry.key,
                child: Text(entry.value),
              ),
            )
            .toList();
      },
    );
  }
}
