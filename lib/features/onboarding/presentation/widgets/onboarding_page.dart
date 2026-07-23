// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../../config/routes/routes_manager.dart';
// import '../../../../../core/utils/colors_manager.dart';
// import '../../../../core/components/custom_button.dart';
// import '../../../../core/helper/responsive_size.dart';
// import '../../../../core/utils/assets_manager.dart';
// import '../../../../l10n/app_localizations.dart';
// import '../manager/onboarding_view_model.dart';
// import 'bottom_gradient_overlay.dart';
// import 'onboarding_indicator.dart';
// import 'onboarding_nav_button.dart';

// class OnboardingPage extends StatelessWidget {
//   const OnboardingPage({
//     super.key,
//     required this.image,
//     required this.title,
//     required this.description,
//   });

//   final String image;
//   final String title;
//   final String description;

//   @override
//   Widget build(BuildContext context) {
//     final currentPage = context.watch<OnboardingViewModel>().state;
//     final vm = context.read<OnboardingViewModel>();
//     final isRTL = Directionality.of(context) == TextDirection.rtl;

//     return Stack(
//       children: [
//         Positioned.fill(child: Image.asset(image, fit: BoxFit.contain)),

//         Positioned.fill(child: BottomGradientOverlay()),

//         SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: RS.size(context, 16)),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Text(
//                   title,
//                   textAlign: TextAlign.center,
//                   style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                     fontSize: RS.font(context, 24),
//                     color: ColorsManager.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 SizedBox(height: RS.size(context, 12)),

//                 Text(
//                   description,
//                   textAlign: TextAlign.center,
//                   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                     fontSize: RS.font(context, 16),
//                     color: ColorsManager.white.withOpacity(0.85),
//                   ),
//                 ),

//                 SizedBox(height: RS.size(context, 24)),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(
//                     3,
//                     (index) => OnboardingIndicator(
//                       index: index,
//                       currentIndex: currentPage,
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: RS.size(context, 32)),

//                 currentPage < 2
//                     ? Padding(
//                         padding: EdgeInsets.only(bottom: RS.size(context, 40)),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             if (currentPage > 0)
//                               OnboardingNavButton(
//                                 icon: isRTL
//                                     ? AssetsManager.angleRight
//                                     : AssetsManager.angleLeft,
//                                 onTap: vm.previousPage,
//                               ),

//                             const Spacer(),

//                             OnboardingNavButton(
//                               icon: isRTL
//                                   ? AssetsManager.angleLeft
//                                   : AssetsManager.angleRight,
//                               onTap: vm.nextPage,
//                             ),
//                           ],
//                         ),
//                       )
//                     : Padding(
//                         padding: EdgeInsets.only(bottom: RS.size(context, 40)),
//                         child: CustomButton(
//                           text: AppLocalizations.of(context)!.startNow,
//                           onPressed: () async {
//                             await vm.finishOnboarding();
//                             Navigator.pushReplacementNamed(
//                               context,
//                               RoutesManager.roleSelection,
//                             );
//                           },
//                         ),
//                       ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/features/onboarding/presentation/widgets/onboarding_checklist_item.dart';

import '../../../../../config/routes/routes_manager.dart';
import '../../../../../core/utils/colors_manager.dart';
import '../../../../core/components/custom_button.dart';
import '../../../../core/helper/responsive_size.dart';
import '../../../../l10n/app_localizations.dart';
import '../manager/onboarding_view_model.dart';
import 'onboarding_indicator.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.checklistItems,
    required this.isLastPage,
    required this.buttonText,
  });

  final String image;
  final String title;
  final List<String> checklistItems;
  final bool isLastPage;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    final currentPage = context.watch<OnboardingViewModel>().state;
    final vm = context.read<OnboardingViewModel>();
    final loc = AppLocalizations.of(context)!;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: RS.size(context, 16)),
          child: Column(
            children: [
              /// ===== Skip Button =====
              SizedBox(
                height: RS.size(context, 40),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () async {
                      await vm.finishOnboarding();
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesManager.roleSelection,
                        );
                      }
                    },
                    child: Text(
                      loc.skip,
                      style: TextStyle(
                        fontSize: RS.font(context, 14),
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.primaryTextDarkColor,
                      ),
                    ),
                  ),
                ),
              ),

              /// ===== Illustration + Floating Badges =====
              Image.asset(image, fit: BoxFit.contain),

              SizedBox(height: RS.size(context, 16)),

              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: RS.font(context, 20),
                  color: ColorsManager.primaryTextDarkColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: RS.size(context, 12)),

              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: checklistItems
                      .map((item) => OnboardingChecklistItem(text: item))
                      .toList(),
                ),
              ),

              SizedBox(height: RS.size(context, 20)),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => OnboardingIndicator(
                    index: index,
                    currentIndex: currentPage,
                  ),
                ),
              ),

              SizedBox(height: RS.size(context, 24)),

              Padding(
                padding: EdgeInsets.only(bottom: RS.size(context, 24)),
                child: CustomButton(
                  text: buttonText,
                  onPressed: () async {
                    if (isLastPage) {
                      await vm.finishOnboarding();
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesManager.roleSelection,
                        );
                      }
                    } else {
                      vm.nextPage();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
