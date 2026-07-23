import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../core/utils/colors_manager.dart';
import '../manager/reset_password_view_model/reset_password_view_model.dart';
import '../widgets/reset_password_view_body.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorsManager.gradientStart,
              ColorsManager.gradientEnd,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: BlocProvider(
            create: (context) => getIt<ResetPasswordViewModel>(),
            child: const ResetPasswordViewBody(),
          ),
        ),
      ),
    );
  }
}