import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/enums/technician_web_tab.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

 

class TechnicianWebDesktopTabs extends StatelessWidget {
  final AppLocalizations loc;
  final TechnicianWebTab currentTab;
  final ValueChanged<TechnicianWebTab> onChanged;

  const TechnicianWebDesktopTabs({
    super.key,
    required this.loc,
    required this.currentTab,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = {
      TechnicianWebTab.home: loc.home,
      TechnicianWebTab.orders: loc.orders,
      TechnicianWebTab.about: loc.aboutUs,
    };

    return Row(
      children: tabs.entries.map((entry) {
        final isActive = currentTab == entry.key;

        return Padding(
          padding: const EdgeInsets.only(right: 32),
          child: InkWell(
            onTap: () => onChanged(entry.key),
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
                    color: Colors.white,
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
