import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../core/utils/colors_manager.dart';
import '../manager/onboarding_view_model.dart';
import '../widgets/onboarding_view_body.dart';


class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

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
         child: BlocProvider(
            create: (context) => getIt<OnboardingViewModel>(),
             child: OnboardingViewBody()),
       ),
    );
  }
}
