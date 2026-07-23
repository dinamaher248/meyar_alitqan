import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/di/di.dart';
import '../../../../../../../profile/techinican/presentation/manager/update_techinican_profile_view_model/update_technician_profile_view_model.dart';
import '../widgets/technician_account_tab_view_body.dart';

class TechnicianAccountTabView extends StatelessWidget {
  const TechnicianAccountTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<UpdateTechnicianProfileViewModel>(),
        child: TechnicianAccountTabViewBody(),
      ),
    );
  }
}
