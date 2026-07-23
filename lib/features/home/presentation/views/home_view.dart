import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cubit/app_user/app_user_cubit.dart';
import '../../../../core/enums/user_role.dart';
import 'customer_home_view.dart';
import 'technician_home_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppUserCubit>().state;

    if (user == null) {
      return const SizedBox();
    }

    return user.role == UserRole.customer.name
        ? const CustomerHomeView()
        : const TechnicianHomeView();
  }
}
