import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/utils/assets_manager.dart';
import '../../../../l10n/app_localizations.dart';
import '../manager/onboarding_view_model.dart';
import 'onboarding_page.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return BlocBuilder<OnboardingViewModel, int>(
      builder: (context, currentPage) {
        final vm = context.read<OnboardingViewModel>();

        return PageView(
          controller: vm.pageController,
          onPageChanged: vm.onPageChanged,
          children: [
            /// ===== Page 1 =====
            OnboardingPage(
              image: AssetsManager.onBoardingImage1,
              title: loc.onboarding_page1_title,
              checklistItems: [
                loc.onboarding_quality_check1,
                loc.onboarding_quality_check2,
                loc.onboarding_quality_check3,
              ],
              
              
              isLastPage: false,
              buttonText: loc.onboardingContinue,
            ),

            /// ===== Page 2 =====
            OnboardingPage(
              image: AssetsManager.onBoardingImage2,
              title: loc.onboarding_page2_title,
              checklistItems: [
                loc.onboarding_service_check1,
                loc.onboarding_service_check2,
                loc.onboarding_service_check3,
              ],
             
              isLastPage: false,
              buttonText: loc.onboardingContinue,
            ),

            /// ===== Page 3 (Last) =====
            OnboardingPage(
              image: AssetsManager.onBoardingImage3,
              title: loc.onboarding_page3_title,
              checklistItems: [
                loc.onboarding_technician_check1,
                loc.onboarding_technician_check2,
                loc.onboarding_technician_check3,
              ],
              isLastPage: true,
              buttonText: loc.startNow,
            ),
          ],
        );
      },
    );
  }
}