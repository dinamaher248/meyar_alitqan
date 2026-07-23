import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../core/utils/colors_manager.dart';
import '../manager/google_auth_view_model/google_auth_view_model.dart';
import '../manager/login_view_model/login_view_model.dart';
import '../widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key, required this.role});

  final String role;

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

          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<LoginViewModel>()),
        
              BlocProvider(create: (context) => getIt<GoogleAuthViewModel>()),
            ],
            child: LoginViewBody(role: role),
          ),
        ),
      ),
    );
  }
}
