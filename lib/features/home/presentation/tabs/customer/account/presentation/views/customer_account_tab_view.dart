import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/components/custom_app_bar.dart';
import '../../../../../../../../core/di/di.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../../auth/presentation/manager/delete_account_view_model/delete_account_view_model.dart';
import '../../../../../../../profile/customer/presentation/manager/update_customer_profile_view_model/update_customer_profile_view_model.dart';
import '../widgets/customer_account_tab_view_body.dart';

class CustomerAccountTabView extends StatelessWidget {
  const CustomerAccountTabView({super.key});

  @override
  Widget build(BuildContext context) {
        final loc = AppLocalizations.of(context)!;

    return Scaffold(
            appBar: CustomAppBar(title: loc.personalFile , centerTitle: true,showBackButton: false,),

      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<UpdateCustomerProfileViewModel>(),
            ),
            BlocProvider(
              create: (context) => getIt<DeleteAccountViewModel>(),
            ),
          ],
          child: const CustomerAccountTabViewBody(),
        ),
      ),
    );
  }
}