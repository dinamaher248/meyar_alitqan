import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/routes_manager.dart';
import '../../../../core/components/custom_button.dart';
import '../../../../core/components/custom_text_field.dart';
import '../../../../core/cubit/app_user/app_user_cubit.dart';
import '../../../../core/helper/responsive_size.dart';
import '../../../../l10n/app_localizations.dart';
import '../manager/complete_profile_view_model/complete_profile_view_model.dart';

class CompleteProfileViewBody extends StatelessWidget {
  const CompleteProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final phoneController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (_) => CompleteProfileViewModel(),
      child: BlocConsumer<CompleteProfileViewModel, CompleteProfileStates>(
        listener: (context, state) {
          if (state is CompleteProfileSuccess) {
            context.read<AppUserCubit>().updatePhone(state.phone);

            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesManager.homeView,
              (_) => false,
            );
          }

          if (state is CompleteProfileError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final isLoading = state is CompleteProfileLoading;

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: RS.size(context, 40)),

                      Text(
                        t.completeProfileTitle,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: RS.font(context, 22),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: RS.size(context, 12)),

                      Text(
                        t.phoneRequiredMessage,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: RS.size(context, 40)),

                      CustomTextFormField(
                        textEditingController: phoneController,
                        hintText: t.phoneNumber,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return t.phoneRequired;
                          }
                          if (value.length < 8) {
                            return t.invalidPhone;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: RS.size(context, 30)),

                      CustomButton(
                        text: t.onboardingContinue,
                        isLoading: isLoading,
                        onPressed: isLoading
                            ? null
                            : () {
                                if (!formKey.currentState!.validate()) {
                                  return;
                                }

                                context
                                    .read<CompleteProfileViewModel>()
                                    .submitPhone(phoneController.text.trim());
                              },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
