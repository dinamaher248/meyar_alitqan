import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/custom_button.dart';
import '../../../../../core/components/custom_text_field.dart';
import '../../../../../core/helper/responsive_size.dart';
import '../../../../../core/utils/colors_manager.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../core/cubit/app_user/app_user_cubit.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../config/routes/routes_manager.dart';
import '../manager/forget_password_view_model/forget_password_view_model.dart';
import '../manager/forget_password_view_model/forget_password_view_model_states.dart';
import 'login_header.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() =>
      _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  final TextEditingController emailController = TextEditingController();

  bool isCooldown = false;
  int secondsLeft = 30;
  Timer? _timer;

  void startCooldown() {
    setState(() {
      isCooldown = true;
      secondsLeft = 30;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft == 1) {
        timer.cancel();
        setState(() {
          isCooldown = false;
        });
      } else {
        setState(() {
          secondsLeft--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return BlocConsumer<ForgetPasswordViewModel, ForgetPasswordViewModelStates>(
      listener: (context, state) {
        if (state is ForgetPasswordViewModelSuccess) {
          startCooldown();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                loc.resetLinkSent,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontSize: RS.font(context, 12),
                ),
              ),
              backgroundColor: Colors.green,
            ),
          );
        }

        if (state is ForgetPasswordViewModelError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: TextStyle(fontSize: RS.font(context, 16)),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is ForgetPasswordViewModelLoading;

        return Column(
          children: [
            const AuthHeader(),

            Image.asset(AssetsManager.logo, width: RS.size(context, 120,)),
                        SizedBox(height: RS.size(context, 180)),

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
                          loc.forgotPassword,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: RS.font(context, 20),
                            color: ColorsManager.primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                
                        SizedBox(height: RS.size(context, 8)),
                
                        Text(
                          loc.forgotPasswordDesc,
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
                            loc.email,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: RS.font(context, 16),
                              color: ColorsManager.primaryTextDarkColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                
                        SizedBox(height: RS.size(context, 12)),
                
                        /// Email
                        CustomTextFormField(
                          textEditingController: emailController,
                          hintText: loc.email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) =>
                              v == null || v.isEmpty ? loc.emailRequired : null,
                        ),
                
                        SizedBox(height: RS.size(context, 24)),
                
                        /// Send Button
                        CustomButton(
                          text: isCooldown
                              ? loc.resendAfterSeconds(secondsLeft)
                              : loc.sendResetLink,
                          isLoading: isLoading,
                          onPressed: (isLoading || isCooldown)
                              ? null
                              : () {
                                  context
                                      .read<ForgetPasswordViewModel>()
                                      .forgetPassword(
                                        email: emailController.text.trim(),
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