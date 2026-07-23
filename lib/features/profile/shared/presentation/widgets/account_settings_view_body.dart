import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meayar_alitqan/core/components/dismissible_error_card.dart';
import 'package:meayar_alitqan/features/profile/shared/presentation/widgets/settings_list.dart';
import 'package:meayar_alitqan/features/profile/shared/presentation/widgets/show_avatar_picker_sheet.dart';
import 'package:meayar_alitqan/features/profile/shared/presentation/widgets/user_profile_avatar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../config/routes/routes_manager.dart';
import '../../../../../core/components/confirmation_dialog.dart';
import '../../../../../core/components/custom_button.dart';
import '../../../../../core/components/custom_text_field.dart';
import '../../../../../core/cubit/app_user/app_user_cubit.dart';
import '../../../../../core/helper/responsive_size.dart';
import '../../../../../core/helper/web_max_width.dart';
import '../../../../../core/services/avatar_upload_service.dart';
import '../../../../../core/services/secure_storage_service.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../auth/presentation/manager/delete_account_view_model/delete_account_view_model.dart';
import '../../../../auth/presentation/manager/delete_account_view_model/delete_account_view_model_states.dart';
import '../../../customer/presentation/manager/update_customer_profile_view_model/update_customer_profile_view_model.dart';
import '../../../customer/presentation/manager/update_customer_profile_view_model/update_customer_profile_view_model_states.dart';
import '../../domain/entities/base_profile_entity/base_profile_entity.dart';
import '../../domain/entities/settings_Item_model/settings_Item_model.dart';
import '../manager/get_current_user_view_model/get_current_user_view_model.dart';

class AccountSettingsViewBody extends StatefulWidget {
  const AccountSettingsViewBody({super.key});

  @override
  State<AccountSettingsViewBody> createState() =>
      _AccountSettingsViewBodyState();
}

class _AccountSettingsViewBodyState extends State<AccountSettingsViewBody> {
  late final TextEditingController nameController;
  late final TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    final user = context.read<AppUserCubit>().state;
    nameController = TextEditingController(text: user?.fullName ?? '');
    phoneController = TextEditingController(text: user?.phone ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<GetCurrentUserViewModel>();
    final user = context.watch<AppUserCubit>().state;
    final isGuest = user == null;
    final avatarService = AvatarUploadService();
    final loc = AppLocalizations.of(context)!;
    return BlocBuilder<AppUserCubit, BaseProfileEntity?>(
      builder: (context, user) {
        if (user == null) {
          return const SizedBox();
        }
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(RS.size(context, 8)),
            child: WebMaxWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserProfileAvatar(
                    name: user?.fullName,
                    imageUrl: user?.avatarUrl,
                    onChange: () {
                      showAvatarPicker(
                        context,
                        onCamera: () async {
                          final url = await avatarService.pickAndUpload(
                            ImageSource.camera,
                          );
                          if (url != null) {
                            context.read<AppUserCubit>().updateAvatar(url);
                            context
                                .read<UpdateCustomerProfileViewModel>()
                                .updateProfile(avatar: url);
                          }
                        },
                        onGallery: () async {
                          final url = await avatarService.pickAndUpload(
                            ImageSource.gallery,
                          );
                          if (url != null) {
                            context.read<AppUserCubit>().updateAvatar(url);
                            context
                                .read<UpdateCustomerProfileViewModel>()
                                .updateProfile(avatar: url);
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: RS.size(context, 24)),
                  Text(
                    AppLocalizations.of(context)!.fullName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: RS.font(context, 18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: RS.size(context, 16)),
                  CustomTextFormField(
                    hintText: AppLocalizations.of(context)!.fullName,
                    textEditingController: nameController,
                  ),
                  SizedBox(height: RS.size(context, 24)),
                  Text(
                    AppLocalizations.of(context)!.email,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: RS.font(context, 18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: RS.size(context, 16)),
                  CustomTextFormField(
                    isEnable: false,
                    hintText: AppLocalizations.of(context)!.email,
                    textEditingController: TextEditingController(
                      text: viewModel.email,
                    ),
                  ),
                  SizedBox(height: RS.size(context, 24)),
                  Text(
                    AppLocalizations.of(context)!.phone,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: RS.font(context, 18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: RS.size(context, 16)),
                  CustomTextFormField(
                    hintText: AppLocalizations.of(context)!.phone,
                    textEditingController: phoneController,
                  ),
                  SizedBox(height: RS.size(context, 70)),
                  BlocListener<
                    UpdateCustomerProfileViewModel,
                    UpdateCustomerProfileViewModelStates
                  >(
                    listener: (context, state) {
                      if (state is UpdateCustomerProfileViewModelError) {
                        showTemporaryMessage(
                          context,
                          state.message,
                          MessageType.error,
                        );
                      }

                      if (state is UpdateCustomerProfileViewModelSuccess) {
                        showTemporaryMessage(
                          context,
                          AppLocalizations.of(
                            context,
                          )!.profileUpdatedSuccessfully,
                          MessageType.success,
                        );

                        context
                            .read<AppUserCubit>()
                            .refreshUser(); // 👈 هنا الصح
                        Navigator.pop(context);
                      }
                    },
                    child:
                        BlocBuilder<
                          UpdateCustomerProfileViewModel,
                          UpdateCustomerProfileViewModelStates
                        >(
                          builder: (context, state) {
                            return CustomButton(
                              isLoading:
                                  state
                                      is UpdateCustomerProfileViewModelLoading,
                              text: AppLocalizations.of(context)!.save,
                              onPressed:
                                  state is UpdateCustomerProfileViewModelLoading
                                  ? null
                                  : () {
                                      context
                                          .read<
                                            UpdateCustomerProfileViewModel
                                          >()
                                          .updateProfile(
                                            name: nameController.text,
                                            phone: phoneController.text,
                                          );
                                    },
                            );
                          },
                        ),
                  ),

                  SizedBox(height: RS.size(context, 100)),
                  if(kIsWeb)
                  Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 420,
                      ),
                      child: InkWell(
                        onTap: () async {
                          showConfirmationDialog(
                            context: context,
                            confirmText: AppLocalizations.of(context)!.yes,
                            cancelText: AppLocalizations.of(context)!.no,
                            title: AppLocalizations.of(context)!.logout,
                            message: AppLocalizations.of(context)!.logoutMessage,
                            onConfirm: () {
                              context.read<AppUserCubit>().clearUser();
                              SecureStorageService().clear();

                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                RoutesManager.customerHome,
                                    (_) => false,
                              );
                            },
                          );
                        },
                        child: Container(
                          height: RS.size(context, 40),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(
                              RS.radius(context, 10),
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  AssetsManager.logout,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.red,
                                    BlendMode.srcIn,
                                  ),
                                  height: RS.size(context, 20),
                                  width: RS.size(context, 20),
                                ),
                                SizedBox(width: RS.size(context, 8)),
                                Text(
                                  AppLocalizations.of(context)!.logout,
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: RS.font(context, 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: RS.size(context, 16)),

                  BlocListener<
                    DeleteAccountViewModel,
                    DeleteAccountViewModelStates
                  >(
                    listener: (context, state) async {
                      if (state is DeleteAccountViewModelLoading) {}

                      if (state is DeleteAccountViewModelError) {
                        showTemporaryMessage(
                          context,
                          state.message,
                          MessageType.error,
                        );
                      }

                      if (state is DeleteAccountViewModelSuccess) {
                        // 1️⃣ Sign out من Supabase
                        await Supabase.instance.client.auth.signOut();

                        // 2️⃣ امسح المستخدم من AppUserCubit
                        context.read<AppUserCubit>().clearUser();

                        // 3️⃣ روح على Login
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          RoutesManager.splash,
                          (route) => false,
                        );

                        // 4️⃣ رسالة تأكيد
                        showTemporaryMessage(
                          context,
                          AppLocalizations.of(
                            context,
                          )!.accountDeletedSuccessfully,
                          MessageType.success,
                        );
                      }
                    },
                    child: InkWell(
                      onTap: () {
                        _showDeleteConfirmation(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _deleteAccountButton(context),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showConfirmationDialog(
      context: context,
      title: AppLocalizations.of(context)!.deleteAccount,
      message: AppLocalizations.of(context)!.areYouSureYouWantToDeleteAccount,
      confirmText: AppLocalizations.of(context)!.yes,
      cancelText: AppLocalizations.of(context)!.no,
      onConfirm: () {
        context.read<DeleteAccountViewModel>().deleteAccount();
      },
    );
  }

  Widget _deleteAccountButton(BuildContext context) {
    return Center(
      child: Container(
        width: kIsWeb ? 420 : double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RS.radius(context, 10)),
          border: Border.all(color: Colors.red, width: RS.size(context, 2)),
        ),
        child: Padding(
          padding: EdgeInsets.all(RS.size(context, 8)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AssetsManager.deleteAccount,
                  colorFilter: const ColorFilter.mode(
                    Colors.red,
                    BlendMode.srcIn,
                  ),
                  height: RS.size(context, 20),
                  width: RS.size(context, 20),
                ),
                SizedBox(width: RS.size(context, 8)),
                Text(
                  AppLocalizations.of(context)!.deleteAccount,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: RS.font(context, 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
