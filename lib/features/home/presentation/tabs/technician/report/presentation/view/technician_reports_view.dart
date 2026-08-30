import 'package:flutter/material.dart';

import '../../../../../../../../core/components/custom_app_bar.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import 'technician_reports_view_body.dart';



class TechnicianReportsView extends StatelessWidget {
  const TechnicianReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.reports,
        centerTitle: true,
      ),
      body: SafeArea(child: TechnicianReportsViewBody()),
    );
  }
}