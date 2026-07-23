import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/app_loader.dart';
import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../l10n/app_localizations.dart';
import '../manager/login_view_model/login_view_model.dart';
import '../manager/login_view_model/login_view_model_states.dart';
import 'login_form.dart';
import 'login_header.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key, required this.role});
  final String role;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginViewModel, LoginViewModelStates>(
      builder: (context, state) {
        final width = MediaQuery.of(context).size.width;
        final isWebDesktop = kIsWeb && width >= 1024;

        return Stack(
          children: [
            isWebDesktop
                ? _WebLoginLayout(role: role)
                : _MobileLoginLayout(role: role),

            if (state is LoginViewModelLoading) const AppLoader(),
          ],
        );
      },
    );
  }
}

class _WebLoginLayout extends StatelessWidget {
  const _WebLoginLayout({required this.role});
  final String role;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// ===== LEFT IMAGE =====
        Expanded(
          flex: 6,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetsManager.loginBackground),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(48),
              alignment: Alignment.centerLeft,
              color: Colors.black.withValues(alpha: 0.4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.loginTitle,
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
                      AppLocalizations.of(context)!.loginSubtitle,
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
              child: LoginForm(role: role),
            ),
          ),
        ),
      ],
    );
  }
}
class _MobileLoginLayout extends StatelessWidget {
  const _MobileLoginLayout({required this.role});

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
            child: LoginForm(role: role),
          ),
        ),
      ],
    );
  }
}