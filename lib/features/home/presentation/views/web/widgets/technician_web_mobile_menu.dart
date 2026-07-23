import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/enums/technician_web_tab.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

 

class TechnicianWebMobileMenu extends StatelessWidget {
  final AppLocalizations loc;
  final ValueChanged<TechnicianWebTab> onSelected;

  const TechnicianWebMobileMenu({
    super.key,
    required this.loc,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<TechnicianWebTab>(
      icon: const Icon(Icons.menu, color: Colors.white),
      onSelected: onSelected,
      itemBuilder: (_) => [
        PopupMenuItem(
          value: TechnicianWebTab.home,
          child: Text(loc.home),
        ),
        PopupMenuItem(
          value: TechnicianWebTab.orders,
          child: Text(loc.orders),
        ),
        PopupMenuItem(
          value: TechnicianWebTab.about,
          child: Text(loc.aboutUs),
        ),
      ],
    );
  }
}
