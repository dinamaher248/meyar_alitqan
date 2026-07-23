import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/enums/web_home_tabs.dart';
import 'package:meayar_alitqan/features/home/presentation/views/web/widgets/customer_web_header.dart';
import 'package:meayar_alitqan/features/home/presentation/views/web/widgets/customer_web_tabs_builder.dart';
import 'package:meayar_alitqan/features/home/presentation/views/web/widgets/customer_web_tabs_content.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';
 

class CustomerHomeWebScaffold extends StatefulWidget {
  const CustomerHomeWebScaffold({super.key});

  @override
  State<CustomerHomeWebScaffold> createState() =>
      _CustomerHomeWebScaffoldState();
}

class _CustomerHomeWebScaffoldState
    extends State<CustomerHomeWebScaffold> {
  WebHomeTab _currentTab = WebHomeTab.home;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobileWeb = width < 1024;

    final loc = AppLocalizations.of(context)!;
    final tabs = buildCustomerWebTabs(loc);

    return Scaffold(
      body: Column(
        children: [
          CustomerWebHeader(
            isMobileWeb: isMobileWeb,
            tabs: tabs,
            currentTab: _currentTab,
            onTabChange: (tab) {
              setState(() => _currentTab = tab);
            },
          ),

          const Divider(height: 1),

          Expanded(
            child: customerWebTabsContent[_currentTab]!,
          ),
        ],
      ),
    );
  }
}
