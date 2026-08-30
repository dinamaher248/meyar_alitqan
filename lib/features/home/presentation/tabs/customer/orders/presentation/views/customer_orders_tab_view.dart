import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/core/components/custom_app_bar.dart';
import 'package:meayar_alitqan/features/reviews/presentation/manager/has_review_view_model/has_review_view_model.dart';

import '../../../../../../../../core/di/di.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../../orders/customer/presentation/manager/cancel_order_view_model/cancel_order_view_model.dart';
import '../widgets/customer_orders_tab_view_body.dart';

class CustomerOrdersTabView extends StatelessWidget {
  const CustomerOrdersTabView({super.key});

  @override
  Widget build(BuildContext context) {
        final loc = AppLocalizations.of(context)!;

    return  Scaffold(
      appBar: CustomAppBar(title: loc.orders , centerTitle: true,showBackButton: false,),
      body: SafeArea(child: MultiBlocProvider(
         providers: [

          BlocProvider(
            create: (context) => getIt<CancelOrderViewModel>(),
          ),
               BlocProvider(
            create: (context) => getIt<HasReviewViewModel>(),
          ),

         ],
          child: CustomerOrdersTabViewBody())),
    );
  }
}
