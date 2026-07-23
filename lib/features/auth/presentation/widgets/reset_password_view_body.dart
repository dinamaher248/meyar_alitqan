import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/custom_button.dart';
import '../../../../../core/components/custom_text_field.dart';
import '../../../../../core/helper/responsive_size.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../config/routes/routes_manager.dart';
import '../../../../core/cubit/app_user/app_user_cubit.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/colors_manager.dart';
import '../manager/reset_password_view_model/reset_password_view_model.dart';
import '../manager/reset_password_view_model/reset_password_view_model_states.dart';
import 'login_header.dart';

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody({super.key});

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loading = false;
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    /// ⏳ Loading أثناء تفعيل السيشن
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return BlocConsumer<ResetPasswordViewModel, ResetPasswordViewModelStates>(
      listener: (context, state) async {
        if (state is ResetPasswordViewModelSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(loc.passwordChangedSuccessfully),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesManager.login,
            (_) => false,
          );
        }

        if (state is ResetPasswordViewModelError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is ResetPasswordViewModelLoading;

        return Column(
          children: [
            const AuthHeader(),

            Image.asset(AssetsManager.logo, height: RS.size(context, 100)),

            Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: RS.size(context, 24)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: RS.size(context, 32)),
                
                        Text(
                          loc.resetPassword,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: RS.font(context, 20),
                            color: ColorsManager.primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                
                        SizedBox(height: RS.size(context, 8)),
                
                        Text(
                          loc.resetPasswordDesc,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: RS.font(context, 13),
                            color: ColorsManager.secondaryTextDarkColor,
                          ),
                        ),
                
                        SizedBox(height: RS.size(context, 32)),
                
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            loc.newPassword,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: RS.font(context, 16),
                              color: ColorsManager.primaryTextDarkColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                
                        SizedBox(height: RS.size(context, 12)),
                
                        /// New Password
                        CustomTextFormField(
                          textEditingController: passwordController,
                          hintText: loc.newPassword,
                          keyboardType: TextInputType.visiblePassword,
                          iconShow: true,
                        ),
                
                        SizedBox(height: RS.size(context, 24)),
                
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            loc.confirmPassword,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: RS.font(context, 16),
                              color: ColorsManager.primaryTextDarkColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                
                        SizedBox(height: RS.size(context, 12)),
                
                        /// Confirm Password
                        CustomTextFormField(
                          textEditingController: confirmPasswordController,
                          hintText: loc.confirmPassword,
                          keyboardType: TextInputType.visiblePassword,
                          iconShow: true,
                        ),
                
                        SizedBox(height: RS.size(context, 24)),
                
                        /// Save Button
                        CustomButton(
                          text: loc.savePassword,
                          isLoading: isLoading,
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (passwordController.text.trim() !=
                                      confirmPasswordController.text.trim()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(loc.passwordNotMatch),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    return;
                                  }
                
                                  context
                                      .read<ResetPasswordViewModel>()
                                      .resetPassword(
                                        newPassword:
                                            passwordController.text.trim(),
                                      );
                                },
                        ),
                
                        SizedBox(height: RS.size(context, 24)),
                
                        /// Continue as guest
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
                            loc.continueAsGuest,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorsManager.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: RS.font(context, 13),
                            ),
                          ),
                        ),
                
                        SizedBox(height: RS.size(context, 32)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}