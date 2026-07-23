import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/enums/technician_web_tab.dart';

import '../../../tabs/customer/home/presentation/widgets/web_about_section.dart';
import '../../../tabs/technician/home/presentation/views/technician_home_tab_view.dart';
import '../../../tabs/technician/jobs/presentation/views/technician_jobs_tab_view.dart';

final Map<TechnicianWebTab, Widget> webTabContent = {
  TechnicianWebTab.home: const TechnicianHomeTabView(),
  TechnicianWebTab.orders: const TechnicianJobsTabView(),
  TechnicianWebTab.about: const WebAboutSection(),
};
