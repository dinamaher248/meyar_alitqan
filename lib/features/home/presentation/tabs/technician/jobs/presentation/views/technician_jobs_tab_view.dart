import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/features/reviews/presentation/manager/has_review_view_model/has_review_view_model.dart';

import '../../../../../../../../core/di/di.dart';
import '../../../../../../../orders/technician/presentation/manager/get_technician_orders_view_model/get_technician_orders_view_model.dart';
import '../widgets/technician_jobs_tab_view_body.dart';

class TechnicianJobsTabView extends StatelessWidget {
  const TechnicianJobsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
             create: (context) => getIt<GetTechnicianOrdersViewModel>(),
          ),
                BlocProvider(
            create: (context) => getIt<HasReviewViewModel>(),
          ),
        ],
          child: TechnicianJobsTabViewBody()),
    );
  }
}
