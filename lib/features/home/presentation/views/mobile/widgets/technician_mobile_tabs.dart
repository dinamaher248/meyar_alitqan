import 'package:flutter/material.dart';

import '../../../tabs/technician/account/presentation/views/technician_account_tab_view.dart';
import '../../../tabs/technician/home/presentation/views/technician_home_tab_view.dart';
import '../../../tabs/technician/jobs/presentation/views/technician_jobs_tab_view.dart';

final List<Widget> technicianMobileTabs = [
  const TechnicianHomeTabView(),
  const TechnicianJobsTabView(),
  const TechnicianAccountTabView(),
];
