import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/core/components/custom_app_bar.dart';

import '../../../../../core/di/di.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../auth/presentation/manager/delete_account_view_model/delete_account_view_model.dart';
import '../../../customer/presentation/manager/update_customer_profile_view_model/update_customer_profile_view_model.dart';
import '../manager/get_current_user_view_model/get_current_user_view_model.dart';
import '../widgets/account_settings_view_body.dart';

class AccountSettingsView extends StatelessWidget {
  const AccountSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.personalFile,
        centerTitle: true,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<GetCurrentUserViewModel>(),
          ),
          BlocProvider(
            create: (context) => getIt<UpdateCustomerProfileViewModel>(),
          ),
          BlocProvider(
            create: (context) => getIt<DeleteAccountViewModel>(),
          ),
        ],

          child: AccountSettingsViewBody()),
    );
  }
}
