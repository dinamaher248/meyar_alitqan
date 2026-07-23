import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/core/cubit/app_user/app_user_cubit.dart';
import 'package:meayar_alitqan/core/enums/technician_web_tab.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

 
import '../widgets/technician_web_header.dart';
import '../widgets/technician_web_tab_content.dart';

class TechnicianHomeWebScaffold extends StatefulWidget {
  const TechnicianHomeWebScaffold({super.key});

  @override
  State<TechnicianHomeWebScaffold> createState() =>
      _TechnicianHomeWebScaffoldState();
}

class _TechnicianHomeWebScaffoldState
    extends State<TechnicianHomeWebScaffold> {
  TechnicianWebTab _currentTab = TechnicianWebTab.home;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final user = context.watch<AppUserCubit>().state!;
    final width = MediaQuery.of(context).size.width;
    final isMobileWeb = width < 1024;

    return Scaffold(
      body: Column(
        children: [
          TechnicianWebHeader(
            isMobileWeb: isMobileWeb,
            loc: loc,
            user: user,
            currentTab: _currentTab,
            onTabChanged: (tab) => setState(() => _currentTab = tab),
          ),
          const Divider(height: 1),
          Expanded(child: webTabContent[_currentTab]!),
        ],
      ),
    );
  }
}
