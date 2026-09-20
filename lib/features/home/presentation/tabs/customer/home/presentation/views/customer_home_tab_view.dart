import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/features/banners/presentation/manager/get_banners_view_model/get_banners_view_model.dart';
import 'package:meayar_alitqan/features/services/presentation/manager/get_main_categories_view_model/get_main_categories_view_model.dart';

import '../../../../../../../../core/di/di.dart';
import '../../../../../../../notifications/presentation/manager/unread_notifications_count_view_model/unread_notifications_count_view_model.dart';
import '../../../../../../../services/presentation/manager/service_model_view_model/service_offers_view_model.dart';
import '../widgets/customer_home_tab_view_body.dart';

class CustomerHomeTabView extends StatelessWidget {
  const CustomerHomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  getIt<UnreadNotificationsCountViewModel>()..load(),
            ),
            BlocProvider(
              create: (context) => getIt<GetServiceOffersViewModel>(),
            ),
          ],

          child: CustomerHomeTabViewBody(),
        ),
      ),
    );
  }
}
