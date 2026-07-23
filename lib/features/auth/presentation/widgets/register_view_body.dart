// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meayar_alitqan/features/auth/presentation/widgets/register_form.dart';

// import '../../../../core/components/app_loader.dart';
// import '../../../../core/utils/assets_manager.dart';
// import '../../../../l10n/app_localizations.dart';
// import '../manager/register_view_model/register_view_model.dart';
// import '../manager/register_view_model/register_view_model_states.dart';
// import 'login_header.dart';

// class RegisterViewBody extends StatelessWidget {
//   const RegisterViewBody({super.key, required this.role});
//   final String role;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<RegisterViewModel, RegisterViewModelStates>(
//       builder: (context, state) {
//         final width = MediaQuery.of(context).size.width;
//         final isWebDesktop = kIsWeb && width >= 1024;

//         return Stack(
//           children: [
//             isWebDesktop
//                 ? _WebRegisterLayout(role: role)
//                 : _MobileRegisterLayout(role: role),

//             if (state is RegisterViewModelStatesLoading)
//               const AppLoader(),
//           ],
//         );
//       },
//     );
//   }
// }

// class _WebRegisterLayout extends StatelessWidget {
//   const _WebRegisterLayout({required this.role});
//   final String role;

//   @override
//   Widget build(BuildContext context) {
//     final loc = AppLocalizations.of(context)!;

//     return Row(
//       children: [
//         /// ===== LEFT IMAGE =====
//         Expanded(
//           flex: 6,
//           child: Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(AssetsManager.registerBackground),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Container(
//               padding: const EdgeInsets.all(48),
//               color: Colors.black.withOpacity(0.45),
//               alignment: Alignment.centerLeft,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     loc.registerTitle,
//                     style: const TextStyle(
//                       fontSize: 36,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   SizedBox(
//                     width: 420,
//                     child: Text(
//                       loc.registerSubtitle,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         color: Colors.white70,
//                         height: 1.6,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),

//         /// ===== RIGHT FORM =====
//         Expanded(
//           flex: 4,
//           child: Center(
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(maxWidth: 420),
//               child: RegisterForm(role: role),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
// class _MobileRegisterLayout extends StatelessWidget {
//   const _MobileRegisterLayout({required this.role});
//   final String role;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Center(
//         child: ConstrainedBox(
//           constraints: const BoxConstraints(maxWidth: 450),
//           child: Column(
//             children: [
//               AuthHeader(),
//               RegisterForm(role: role),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/features/auth/presentation/widgets/register_form.dart';

import '../../../../core/components/app_loader.dart';
import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../l10n/app_localizations.dart';
import '../manager/register_view_model/register_view_model.dart';
import '../manager/register_view_model/register_view_model_states.dart';
import 'login_header.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key, required this.role});
  final String role;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterViewModel, RegisterViewModelStates>(
      builder: (context, state) {
        final width = MediaQuery.of(context).size.width;
        final isWebDesktop = kIsWeb && width >= 1024;

        return Stack(
          children: [
            isWebDesktop
                ? _WebRegisterLayout(role: role)
                : _MobileRegisterLayout(role: role),

            if (state is RegisterViewModelStatesLoading)
              const AppLoader(),
          ],
        );
      },
    );
  }
}

class _WebRegisterLayout extends StatelessWidget {
  const _WebRegisterLayout({required this.role});
  final String role;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Row(
      children: [
        /// ===== LEFT IMAGE =====
        Expanded(
          flex: 6,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetsManager.registerBackground),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(48),
              color: Colors.black.withOpacity(0.45),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.registerTitle,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 420,
                    child: Text(
                      loc.registerSubtitle,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        /// ===== RIGHT FORM =====
        Expanded(
          flex: 4,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: RegisterForm(role: role),
            ),
          ),
        ),
      ],
    );
  }
}

class _MobileRegisterLayout extends StatelessWidget {
  const _MobileRegisterLayout({required this.role});
  final String role;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AuthHeader(),

        Image.asset(AssetsManager.logo, height: RS.size(context, 100)),

        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: RegisterForm(role: role),
          ),
        ),
      ],
    );
  }
}