import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/utils/assets_manager.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

 
import '../../../tabs/shared/widgets/custom_bottom_nav_bar.dart';
import '../widgets/customer_mobile_tabs.dart';

class CustomerHomeMobileScaffold extends StatefulWidget {
  const CustomerHomeMobileScaffold({super.key});

  @override
  State<CustomerHomeMobileScaffold> createState() =>
      _CustomerHomeMobileScaffoldState();
}

class _CustomerHomeMobileScaffoldState
    extends State<CustomerHomeMobileScaffold> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final items = [
      BottomNavItem(
        label: loc.home,
        icon: AssetsManager.home,
        activeIcon: AssetsManager.home,
      ),
      BottomNavItem(
        label: loc.orders,
        icon: AssetsManager.orders,
        activeIcon: AssetsManager.orders,
      ),
      BottomNavItem(
        label: loc.account,
        icon: AssetsManager.user,
        activeIcon: AssetsManager.user,
      ),
    ];

    return Scaffold(
      extendBody: true,
      body: customerMobileTabs[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        items: items,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
