// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:meayar_alitqan/core/components/or_divider.dart';
// import 'package:meayar_alitqan/features/auth/presentation/widgets/social_login_button.dart';

// import '../../../../config/routes/routes_manager.dart';
// import '../../../../core/components/custom_button.dart';
// import '../../../../core/components/custom_text_field.dart';
// import '../../../../core/components/mobile_number_field.dart';
// import '../../../../core/cubit/app_user/app_user_cubit.dart';
// import '../../../../core/di/di.dart';
// import '../../../../core/enums/user_role.dart';
// import '../../../../core/errors/supabase_register_error_mapper.dart';
// import '../../../../core/helper/responsive_size.dart';
// import '../../../../core/utils/assets_manager.dart';
// import '../../../../core/utils/colors_manager.dart';
// import '../../../../core/validators/register_validators.dart';
// import '../../../../l10n/app_localizations.dart';
// import '../../../profile/shared/domain/use_cases/get_current_user_usecase/get_current_user_usecase.dart';
// import '../manager/google_auth_view_model/google_auth_view_model.dart';
// import '../manager/google_auth_view_model/google_auth_view_model_states.dart';
// import '../manager/register_view_model/register_view_model.dart';
// import '../manager/register_view_model/register_view_model_states.dart';
// import '../manager/verify_otp_view_model/verify_otp_view_model.dart';
// import '../views/otp_view.dart';
// import 'build_privacy_policy.dart';

// class RegisterForm extends StatelessWidget {
//   const RegisterForm({super.key, required this.role});

//   final String role;

//   @override
//   Widget build(BuildContext context) {
//     final vm = context.read<RegisterViewModel>();
//     final loc = AppLocalizations.of(context)!;

//     return BlocConsumer<RegisterViewModel, RegisterViewModelStates>(
//       listener: (context, state) async {
//         if (state is RegisterViewModelStatesError ) {
//           final message = SupabaseRegisterErrorMapper.getMessage(
//             state.message,
//             loc,
//           );

//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(SnackBar(content: Text(message)));
//         }

//         if (state is RegisterViewModelStatesSuccess) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => BlocProvider(
//                 create: (_) => getIt<VerifyOtpViewModel>(),
//                 child: OtpView(
//                   email: state.authEntity.email,
//                 ),
//               ),
//             ),
//           );
//         }
//       },

//       builder: (context, state) {
//         return Form(
//           key: vm.formKey,
//           autovalidateMode: vm.submitted
//               ? AutovalidateMode.onUserInteraction
//               : AutovalidateMode.disabled,
//           child: Stack(
//             children: [
//               SingleChildScrollView(
//                 padding: const EdgeInsets.all(8),
//                 child: Column(
//                   children: [
//                     SizedBox(height: RS.size(context, 12)),
//                     Text(
//                       loc.register,
//                       style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                         fontSize: RS.font(context, 24),
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: RS.size(context, 26)),

//                     /// Full Name
//                     CustomTextFormField(
//                       textEditingController: vm.fullNameController,
//                       hintText: loc.fullName,
//                       keyboardType: TextInputType.name,
//                       validator: (v) =>
//                           RegisterValidators.name(v, loc.fullNameRequired),
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.all(RS.size(context, 10)),
//                         child: SvgPicture.asset(
//                           AssetsManager.user,
//                           width: RS.size(context, 18),
//                           height: RS.size(context, 18),
//                         ),
//                       ),
//                     ),

//                     SizedBox(height: RS.size(context, 16)),

//                     /// Email
//                     CustomTextFormField(
//                       textEditingController: vm.emailController,
//                       hintText: loc.email,
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (v) => RegisterValidators.email(
//                         v,
//                         loc.emailRequired,
//                         loc.invalidEmail,
//                       ),
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.all(RS.size(context, 10)),
//                         child: SvgPicture.asset(
//                           AssetsManager.email,
//                           width: RS.size(context, 18),
//                           height: RS.size(context, 18),
//                         ),
//                       ),
//                     ),

//                     SizedBox(height: RS.size(context, 16)),

//                     /// Password
//                     CustomTextFormField(
//                       textEditingController: vm.passwordController,
//                       hintText: loc.password,
//                       keyboardType: TextInputType.visiblePassword,
//                       iconShow: true,
//                       validator: (v) => RegisterValidators.password(
//                         v,
//                         loc.passwordRequired,
//                         loc.invalidPassword,
//                       ),
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.all(RS.size(context, 10)),
//                         child: SvgPicture.asset(
//                           AssetsManager.lock,
//                           width: RS.size(context, 18),
//                           height: RS.size(context, 18),
//                         ),
//                       ),
//                     ),

//                     SizedBox(height: RS.size(context, 16)),

//                     MobileNumberField(
//                       controller: vm.phoneController,
//                       hintText: loc.phone,
//                       validator: (v) => RegisterValidators.phone(
//                         v,
//                         loc.phoneRequired,
//                         loc.invalidPhone,
//                       ),
//                     ),

//                     SizedBox(height: RS.size(context, 16)),
//                     PrivacyPolicyWithCheck(context: context,
//                           onPrivacyPolicyTap: (_) {
//                             Navigator.pushNamed(
//                               context,
//                               RoutesManager.privacyPolicyView,
//                             );
//                           },
//                            onTermsTap: (_) {
//                             Navigator.pushNamed(
//                               context,
//                               RoutesManager.termsAndConditionsView,
//                             );
//   },),

//                     SizedBox(height: RS.size(context, 20)),

//                     /// Register
//                     CustomButton(
//                       text: loc.registerButton,

//                       onPressed: state is RegisterViewModelStatesLoading
//                           ? null
//                           : () {
//                               vm.markSubmitted();
//                               if (!vm.formKey.currentState!.validate()) return;

//                               vm.sendOtp(

//                               );
//                             },
//                     ),

//                     SizedBox(height: RS.size(context, 20)),
//                     const _LoginRow(),
//                     SizedBox(height: RS.size(context, 20)),
//                     const OrDivider(),
//                     SizedBox(height: RS.size(context, 20)),

//                     BlocConsumer<
//                         GoogleAuthViewModel,
//                         GoogleAuthViewModelStates
//                     >(
//                       listener: (context, state) {
//                         if (state is GoogleAuthViewModelSuccess) {
//                           final profile = state.user;

//                           context.read<AppUserCubit>().setUser(profile);

//                           final hasPhone =
//                               profile.phone != null && profile.phone!.trim().isNotEmpty;

//                           if (hasPhone) {
//                             Navigator.pushNamedAndRemoveUntil(
//                               context,
//                               RoutesManager.homeView,
//                                   (_) => false,
//                             );
//                           } else {
//                             Navigator.pushNamedAndRemoveUntil(
//                               context,
//                               RoutesManager.completeProfileView,
//                                   (_) => false,
//                             );
//                           }
//                         }
//                         if (state is GoogleAuthViewModelError) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text(state.message)),
//                           );
//                         }
//                       },
//                       builder: (context, state) {
//                         if (state is GoogleAuthViewModelLoading) {
//                           return const CircularProgressIndicator();
//                         }

//                         return SocialLoginButton(
//                           iconPath: AssetsManager.google,
//                           label: loc.google,
//                           onPressed: () {
//                             context
//                                 .read<GoogleAuthViewModel>()
//                                 .signInWithGoogle();
//                           },
//                         );
//                       },
//                     ),

//                     SizedBox(height: RS.size(context, 60)),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class _LoginRow extends StatelessWidget {
//   const _LoginRow();

//   @override
//   Widget build(BuildContext context) {
//     final loc = AppLocalizations.of(context)!;
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           loc.alreadyHaveAccount,
//           style: Theme.of(
//             context,
//           ).textTheme.bodyLarge?.copyWith(fontSize: RS.font(context, 13)),
//         ),
//         SizedBox(width: RS.size(context, 5)),
//         GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Text(
//             loc.login,
//             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//               fontSize: RS.font(context, 13),
//               color: ColorsManager.primaryColor,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meayar_alitqan/features/auth/presentation/widgets/build_privacy_policy.dart';

import '../../../../config/routes/routes_manager.dart';
import '../../../../core/components/custom_button.dart';
import '../../../../core/components/custom_text_field.dart';
import '../../../../core/components/mobile_number_field.dart';
import '../../../../core/cubit/app_user/app_user_cubit.dart';
import '../../../../core/di/di.dart';
import '../../../../core/errors/supabase_register_error_mapper.dart';
import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/colors_manager.dart';
import '../../../../core/validators/register_validators.dart';
import '../../../../l10n/app_localizations.dart';
import '../manager/google_auth_view_model/google_auth_view_model.dart';
import '../manager/google_auth_view_model/google_auth_view_model_states.dart';
import '../manager/register_view_model/register_view_model.dart';
import '../manager/register_view_model/register_view_model_states.dart';
import '../manager/verify_otp_view_model/verify_otp_view_model.dart';
import '../views/otp_view.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key, required this.role});

  final String role;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<RegisterViewModel>();
    final loc = AppLocalizations.of(context)!;

    return BlocConsumer<RegisterViewModel, RegisterViewModelStates>(
      // ================= LOGIC UNCHANGED =================
      listener: (context, state) async {
        if (state is RegisterViewModelStatesError) {
          final message = SupabaseRegisterErrorMapper.getMessage(
            state.message,
            loc,
          );

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        }

        if (state is RegisterViewModelStatesSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => getIt<VerifyOtpViewModel>(),
                child: OtpView(email: state.authEntity.email),
              ),
            ),
          );
        }
      },
      // =====================================================
      builder: (context, state) {
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
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: RS.size(context, 20)),

                      Text(
                        loc.registerTitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: RS.font(context, 20),
                          color: ColorsManager.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: RS.size(context, 8)),
                      Text(
                        loc.registerSubtitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: RS.font(context, 19),
                          color: ColorsManager.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      SizedBox(height: RS.size(context, 32)),

                      /// Full Name
                      _FieldLabel(text: loc.fullName),
                      SizedBox(height: RS.size(context, 12)),
                      CustomTextFormField(
                        textEditingController: vm.fullNameController,
                        hintText: loc.fullName,
                        keyboardType: TextInputType.name,
                        validator: (v) =>
                            RegisterValidators.name(v, loc.fullNameRequired),
                      ),

                      SizedBox(height: RS.size(context, 24)),

                      /// Email
                      _FieldLabel(text: loc.email),
                      SizedBox(height: RS.size(context, 12)),
                      CustomTextFormField(
                        textEditingController: vm.emailController,
                        hintText: loc.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) => RegisterValidators.email(
                          v,
                          loc.emailRequired,
                          loc.invalidEmail,
                        ),
                      ),

                      SizedBox(height: RS.size(context, 24)),

                      /// Password
                      _FieldLabel(text: loc.password),
                      SizedBox(height: RS.size(context, 12)),
                      CustomTextFormField(
                        textEditingController: vm.passwordController,
                        hintText: loc.password,
                        keyboardType: TextInputType.visiblePassword,
                        iconShow: true,
                        validator: (v) => RegisterValidators.password(
                          v,
                          loc.passwordRequired,
                          loc.invalidPassword,
                        ),
                      ),

                      SizedBox(height: RS.size(context, 24)),

                      /// Phone
                      _FieldLabel(text: loc.phone),
                      SizedBox(height: RS.size(context, 12)),
                      MobileNumberField(
                        controller: vm.phoneController,
                        hintText: loc.phone,
                        validator: (v) => RegisterValidators.phone(
                          v,
                          loc.phoneRequired,
                          loc.invalidPhone,
                        ),
                      ),

                      SizedBox(height: RS.size(context, 20)),

                      PrivacyPolicyWithCheck(
                        context: context,
                        onPrivacyPolicyTap: (_) {
                          Navigator.pushNamed(
                            context,
                            RoutesManager.privacyPolicyView,
                          );
                        },
                        onTermsTap: (_) {
                          Navigator.pushNamed(
                            context,
                            RoutesManager.termsAndConditionsView,
                          );
                        },
                      ),

                      SizedBox(height: RS.size(context, 26)),

                      /// Register Button
                      CustomButton(
                        text: loc.registerButton,
                        onPressed: state is RegisterViewModelStatesLoading
                            ? null
                            : () {
                                vm.markSubmitted();
                                if (!vm.formKey.currentState!.validate())
                                  return;

                                vm.sendOtp();
                              },
                      ),

                      SizedBox(height: RS.size(context, 32)),

                      Text(
                        loc.orLoginWith,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: RS.font(context, 14),
                          fontWeight: FontWeight.w500,
                          color: ColorsManager.secondaryTextDarkColor,
                        ),
                      ),

                      SizedBox(height: RS.size(context, 20)),

                      BlocConsumer<
                        GoogleAuthViewModel,
                        GoogleAuthViewModelStates
                      >(
                        listener: (context, state) {
                          if (state is GoogleAuthViewModelSuccess) {
                            final profile = state.user;

                            context.read<AppUserCubit>().setUser(profile);

                            final hasPhone =
                                profile.phone != null &&
                                profile.phone!.trim().isNotEmpty;

                            if (hasPhone) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                RoutesManager.homeView,
                                (_) => false,
                              );
                            } else {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                RoutesManager.completeProfileView,
                                (_) => false,
                              );
                            }
                          }
                          if (state is GoogleAuthViewModelError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is GoogleAuthViewModelLoading) {
                            return const CircularProgressIndicator();
                          }

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(100),
                                onTap: () {
                                  context
                                      .read<GoogleAuthViewModel>()
                                      .signInWithGoogle();
                                },
                                child: Container(
                                  width: RS.size(context, 80),
                                  height: RS.size(context, 70),
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
                                  width: RS.size(context, 80),
                                  height: RS.size(context, 70),
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
                      const _LoginRow(),
                      SizedBox(height: RS.size(context, 20)),
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

/// Label matching the exact style used above each field in LoginForm.
class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontSize: RS.font(context, 16),
          color: ColorsManager.primaryTextDarkColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _LoginRow extends StatelessWidget {
  const _LoginRow();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          loc.alreadyHaveAccount,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: RS.font(context, 14),
            fontWeight: FontWeight.w600,
            color: ColorsManager.darkGrey,
          ),
        ),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            loc.login,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: ColorsManager.primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: RS.font(context, 14),
            ),
          ),
        ),
      ],
    );
  }
}
