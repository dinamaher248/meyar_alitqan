import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/di.dart';
import '../../../../core/utils/colors_manager.dart';
import '../manager/google_auth_view_model/google_auth_view_model.dart';
import '../manager/register_view_model/register_view_model.dart';
import '../widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key, required this.role});

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
              BlocProvider(
                create: (context) => getIt<RegisterViewModel>(),
              ),
        
              BlocProvider(
                create: (context) => getIt<GoogleAuthViewModel>(),
              ),
            ],
            child: RegisterViewBody(role: role),
          ),
        ),
      ),
    );
  }
}
