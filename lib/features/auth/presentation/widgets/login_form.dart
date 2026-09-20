import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/components/custom_button.dart';
import '../../../../../core/components/custom_text_field.dart';
import '../../../../../core/helper/responsive_size.dart';
import '../../../../../core/utils/colors_manager.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../config/routes/routes_manager.dart';
import '../../../../core/cubit/app_user/app_user_cubit.dart';
import '../../../../core/enums/user_role.dart';
import '../../../../core/errors/supabase_login_error_mapper.dart';
import '../../../../core/utils/assets_manager.dart';
import '../manager/google_auth_view_model/google_auth_view_model.dart';
import '../manager/google_auth_view_model/google_auth_view_model_states.dart';
import '../manager/login_view_model/login_view_model.dart';
import '../manager/login_view_model/login_view_model_states.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key, this.role});

  final String? role;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<LoginViewModel>();
    final loc = AppLocalizations.of(context)!;

    return BlocConsumer<LoginViewModel, LoginViewModelStates>(
      listener: (context, state) {
        debugPrint('🟡 LoginForm Listener State: ${state.runtimeType}');

        if (state is LoginViewModelError) {
          debugPrint('🔴 Login Error: ${state.message}');
          vm.formKey.currentState?.validate();
        }

        if (state is LoginViewModelSuccess) {
          debugPrint('🟢 Login Success');

          context.read<AppUserCubit>().setUser(state.profile);

          debugPrint('➡️ Navigating to HomeView');

          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesManager.homeView,
            (_) => false,
          );
        }
      },
      builder: (context, state) {
        debugPrint('🔵 LoginForm Builder State: ${state.runtimeType}');

        final isLoading = state is LoginViewModelLoading;

        return Form(
          key: vm.formKey,
          autovalidateMode: vm.submitted
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: SizedBox.expand(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24),

                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: kIsWeb
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      SizedBox(height: RS.size(context, 20)),
                      Text(
                        loc.welcomeBack,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: RS.font(context, 20),
                          color: ColorsManager.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: RS.size(context, 8)),
                      Text(
                        loc.loginSubtitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: RS.font(context, 19),
                          color: ColorsManager.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: RS.size(context, 43)),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          loc.email,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontSize: RS.font(context, 16),
                                color: ColorsManager.primaryTextDarkColor,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                      SizedBox(height: RS.size(context, 12)),

                      /// Email
                      CustomTextFormField(
                        textEditingController: vm.emailController,
                        hintText: loc.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) =>
                            v == null || v.isEmpty ? loc.emailRequired : null,
                      ),

                      SizedBox(height: RS.size(context, 24)),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          loc.password,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontSize: RS.font(context, 16),
                                color: ColorsManager.primaryTextDarkColor,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                      SizedBox(height: RS.size(context, 12)),

                      /// Password
                      CustomTextFormField(
                        textEditingController: vm.passwordController,
                        hintText: loc.password,
                        keyboardType: TextInputType.visiblePassword,
                        iconShow: true,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return loc.passwordRequired;
                          }

                          if (vm.loginError != null) {
                            return SupabaseLoginErrorMapper.getMessage(
                              vm.loginError!,
                              loc,
                            );
                          }

                          return null;
                        },
                        onChanged: (_) {
                          vm.clearError();
                          vm.formKey.currentState?.validate();
                        },
                      ),
                      SizedBox(height: RS.size(context, 8)),

                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RoutesManager.forgotPasswordView,
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.forgotPassword,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: ColorsManager.primaryTextDarkColor,
                                  fontSize: RS.font(context, 14),
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),

                      SizedBox(height: RS.size(context, 26)),

                      /// Login Button
                      CustomButton(
                        text: loc.loginButton,
                        onPressed: isLoading
                            ? null
                            : () {
                                vm.clearError();
                                vm.markSubmitted();

                                if (!vm.formKey.currentState!.validate())
                                  return;

                                vm.login(
                                  email: vm.emailController.text,
                                  password: vm.passwordController.text,
                                );
                              },
                      ),
                      SizedBox(height: RS.size(context, 20)),
                      if (role == UserRole.customer.name) ...[
                        Text(
                          loc.orLoginWith,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontSize: RS.font(context, 14),
                                fontWeight: FontWeight.w500,
                                color: ColorsManager.secondaryTextDarkColor,
                              ),
                        ),
                      ],
                      if (role == UserRole.customer.name) ...[
                        SizedBox(height: RS.size(context, 20)),
                        BlocConsumer<
                          GoogleAuthViewModel,
                          GoogleAuthViewModelStates
                        >(
                          listener: (context, state) {
                            if (state is GoogleAuthViewModelSuccess) {
                              context.read<AppUserCubit>().setUser(state.user);

                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                RoutesManager.homeView,
                                (_) => false,
                              );
                            }
                          },
                          builder: (context, state) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(100),
                                  onTap: state is GoogleAuthViewModelLoading
                                      ? null
                                      : () {
                                          context
                                              .read<GoogleAuthViewModel>()
                                              .signInWithGoogle();
                                        },
                                  child: Container(
                                    width: RS.size(context, 60),
                                    height: RS.size(context, 50),
                                    decoration: BoxDecoration(
                                      color: ColorsManager.lightGrey,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(14),
                                      child: SvgPicture.asset(
                                        AssetsManager.google,
                                        width: RS.size(context, 15),
                                        height: RS.size(context, 15),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: RS.size(context, 16)),

                                InkWell(
                                  borderRadius: BorderRadius.circular(100),
                                  onTap: () {
                                    // Apple Sign In
                                  },
                                  child: Container(
                                    width: RS.size(context, 60),
                                    height: RS.size(context, 50),
                                    decoration: BoxDecoration(
                                      color: ColorsManager.lightGrey,
                                      borderRadius: BorderRadius.circular(10),

                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.apple,
                                      size: RS.size(context, 40),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: RS.size(context, 18)),
                        if (role == UserRole.customer.name) ...[
                          // SizedBox(height: RS.size(context, 32)),
                          _RegisterRow(),
                        ],
                        SizedBox(height: RS.size(context, 12)),

                        if (!kIsWeb)
                          GestureDetector(
                            onTap: () {
                              context.read<AppUserCubit>().setGuest();
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                RoutesManager.customerHome,
                                (_) => false,
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.continueAsGuest,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: ColorsManager.primaryColor,
                                    fontSize: RS.font(context, 13),
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        SizedBox(height: RS.size(context, 32)),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RegisterRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.dontHaveAccount,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: RS.font(context, 14),
              fontWeight: FontWeight.w600,
              color: ColorsManager.darkGrey,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                RoutesManager.register,
                arguments: UserRole.customer.name,
              );
            },
            child: Text(
              AppLocalizations.of(context)!.createNewAccount,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorsManager.primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: RS.font(context, 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
