import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meayar_alitqan/core/components/confirmation_dialog.dart';
import 'package:meayar_alitqan/core/components/dismissible_error_card.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/header_pages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../config/routes/routes_manager.dart';
import '../../../../../../../../core/cubit/app_user/app_user_cubit.dart';
import '../../../../../../../../core/helper/responsive_size.dart';
import '../../../../../../../../core/services/avatar_upload_service.dart';
import '../../../../../../../../core/services/secure_storage_service.dart';
import '../../../../../../../../core/utils/assets_manager.dart';
import '../../../../../../../../core/utils/colors_manager.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../../auth/presentation/manager/delete_account_view_model/delete_account_view_model.dart';
import '../../../../../../../auth/presentation/manager/delete_account_view_model/delete_account_view_model_states.dart';
import '../../../../../../../profile/customer/presentation/manager/update_customer_profile_view_model/update_customer_profile_view_model.dart';
import '../../../../../../../profile/shared/domain/entities/settings_Item_model/settings_Item_model.dart';
import '../../../../../../../profile/shared/presentation/widgets/app_language_view_body.dart';
import '../../../../../../../profile/shared/presentation/widgets/settings_list.dart';
import '../../../../../../../profile/shared/presentation/widgets/show_avatar_picker_sheet.dart';
import '../../../../../../../profile/shared/presentation/widgets/user_profile_avatar.dart';

class CustomerAccountTabViewBody extends StatelessWidget {
  const CustomerAccountTabViewBody({super.key});

  void _showGuestMessage(BuildContext context, AppLocalizations loc) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(loc.guestActionNotAllowed),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppUserCubit>().state;
    final isGuest = user == null;
    final avatarService = AvatarUploadService();
    final loc = AppLocalizations.of(context)!;

    return BlocListener<DeleteAccountViewModel, DeleteAccountViewModelStates>(
      listener: (context, state) async {
        if (state is DeleteAccountViewModelError) {
          showTemporaryMessage(
            context,
            state.message,
            MessageType.error,
          );
        }

        if (state is DeleteAccountViewModelSuccess) {
          /// 1️⃣ Sign out من Supabase
          await Supabase.instance.client.auth.signOut();

          /// 2️⃣ امسح المستخدم من AppUserCubit
          context.read<AppUserCubit>().clearUser();
          SecureStorageService().clear();

          /// 3️⃣ روح على Splash
          Navigator.of(context).pushNamedAndRemoveUntil(
            RoutesManager.splash,
            (route) => false,
          );

          /// 4️⃣ رسالة تأكيد
          showTemporaryMessage(
            context,
            loc.accountDeletedSuccessfully,
            MessageType.success,
          );
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: RS.size(context, 16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: RS.size(context, 16)),

              /// ===== Header =====
              // HeaderPages(title: loc.personalFile),

              // SizedBox(height: RS.size(context, 20)),

              /// ================= AVATAR =================
              UserProfileAvatar(
                name: user?.fullName,
                imageUrl: user?.avatarUrl,
                onChange: () {
                  if (isGuest) {
                    _showGuestMessage(context, loc);
                    return;
                  }

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

              SizedBox(height: RS.size(context, 20)),

              /// ================= SETTINGS =================
              SettingsList(
                items: [
                  SettingsItemModel(
                    title: loc.accountSettings,
                    icon: AssetsManager.settings,
                    onTap: () {
                      if (isGuest) {
                        _showGuestMessage(context, loc);
                        return;
                      }
                      Navigator.pushNamed(
                        context,
                        RoutesManager.accountSettingsView,
                      );
                    },
                  ),
                  SettingsItemModel(
                    title: loc.appLanguage,
                    icon: AssetsManager.globe,
                    onTap: () {
                      showLanguagePickerSheet(context);
                    },
                  ),
                  SettingsItemModel(
                    title: loc.faq,
                    icon: AssetsManager.questions,
                    onTap: () {
                      Navigator.pushNamed(context, RoutesManager.faqView);
                    },
                  ),
                  SettingsItemModel(
                    title: loc.termsAndConditions,
                    icon: AssetsManager.work,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RoutesManager.termsAndConditionsView,
                      );
                    },
                  ),
                  SettingsItemModel(
                    title: loc.contactUs,
                    icon: AssetsManager.customerService,
                    onTap: () {
                      Navigator.pushNamed(context, RoutesManager.contactUs);
                    },
                  ),
                ],
              ),

              SizedBox(height: RS.size(context, 24)),
              Divider(color: ColorsManager.lightGrey),

              if (!isGuest) ...[
                /// ===== Logout + Delete Account =====
                SettingsList(
                  items: [
                    SettingsItemModel(
                      title: loc.logout,
                      icon: AssetsManager.logout,
                      type: SettingsTileType.logout,
                      onTap: () {
                        showConfirmationDialog(
                          context: context,
                          confirmText: loc.confirm,
                          cancelText: loc.back,
                          title: loc.logout,
                          message: loc.logoutMessage,
                          icon: Icons.logout,
                          onConfirm: () {
                            context.read<AppUserCubit>().clearUser();
                            SecureStorageService().clear();

                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RoutesManager.splash,
                              (_) => false,
                            );
                          },
                        );
                      },
                    ),

                    /// ✅ دلوقتي بتنادي الـ Use Case الحقيقي
                    SettingsItemModel(
                      title: loc.deleteAccountAction,
                      icon: AssetsManager.logout,
                      type: SettingsTileType.logout,
                      onTap: () {
                        showConfirmationDialog(
                          context: context,
                          confirmText: loc.confirm,
                          cancelText: loc.back,
                          title: loc.deleteAccountAction,
                          message: loc.areYouSureYouWantToDeleteAccount,
                          icon: Icons.person_off_outlined,
                          onConfirm: () {
                            context.read<DeleteAccountViewModel>().deleteAccount();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],

              if (isGuest)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: RS.size(context, 16)),
                  child: Container(
                    height: RS.size(context, 50),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorsManager.white,
                      border: Border.all(color: ColorsManager.primaryColor),
                      borderRadius:
                          BorderRadius.circular(RS.radius(context, 12)),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RoutesManager.splash,
                          (_) => false,
                        );
                      },
                      child: Text(
                        loc.login,
                        style: TextStyle(
                          color: ColorsManager.primaryColor,
                          fontSize: RS.font(context, 16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

              SizedBox(height: RS.size(context, 24)),
            ],
          ),
        ),
      ),
    );
  }
}