import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/features/reviews/presentation/manager/has_review_view_model/has_review_view_model.dart';
import 'package:meayar_alitqan/features/spare_parts/presentation/manager/add_spare_part_view_model/add_spare_part_view_model.dart';
import 'package:meayar_alitqan/features/spare_parts/presentation/manager/get_spare_part_view_model/get_spare_part_view_model.dart';

import '../../../../../../../../core/di/di.dart';
import '../../../../../../../notifications/presentation/manager/unread_notifications_count_view_model/unread_notifications_count_view_model.dart';
import '../../../../../../../orders/technician/presentation/manager/get_technician_orders_view_model/get_technician_orders_view_model.dart';
import '../widgets/technician_home_tab_view_body.dart';

class TechnicianHomeTabView extends StatelessWidget {
  const TechnicianHomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<GetTechnicianOrdersViewModel>(),
          ),
          BlocProvider(
            create: (context) => getIt<UnreadNotificationsCountViewModel>()..load(),
          ),
              BlocProvider(
            create: (context) => getIt<HasReviewViewModel>(),
          ),
             BlocProvider(
        create: (_) => getIt<GetSparePartViewModel>()
      ),
         BlocProvider(
        create: (_) => getIt<AddSparePartViewModel>() ,
      ),
        ],

          child: TechnicianHomeTabViewBody()),
    );
  }
}
