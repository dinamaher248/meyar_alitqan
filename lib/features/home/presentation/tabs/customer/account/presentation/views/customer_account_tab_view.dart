import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/di/di.dart';
import '../../../../../../../profile/customer/presentation/manager/update_customer_profile_view_model/update_customer_profile_view_model.dart';
import '../widgets/customer_account_tab_view_body.dart';

class CustomerAccountTabView extends StatelessWidget {
  const CustomerAccountTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(child: BlocProvider(
          create: (context) => getIt<UpdateCustomerProfileViewModel>(),
          child: CustomerAccountTabViewBody())),
    );
  }
}
