import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meayar_alitqan/core/components/confirmation_dialog.dart';

import '../../../../../../../../config/routes/routes_manager.dart';
import '../../../../../../../../core/cubit/app_user/app_user_cubit.dart';
import '../../../../../../../../core/helper/responsive_size.dart';
import '../../../../../../../../core/services/avatar_upload_service.dart';
import '../../../../../../../../core/services/secure_storage_service.dart';
import '../../../../../../../../core/utils/assets_manager.dart';
import '../../../../../../../../core/utils/colors_manager.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../../profile/customer/presentation/manager/update_customer_profile_view_model/update_customer_profile_view_model.dart';
import '../../../../../../../profile/shared/domain/entities/settings_Item_model/settings_Item_model.dart';
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

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: RS.size(context, 30),
            color: ColorsManager.primaryColor.withOpacity(.1),
          ),

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

          SizedBox(height: RS.size(context, 16)),

          /// ================= SETTINGS =================
          SettingsList(
            items: [
              /// Account settings
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

              /// App language (allowed for guest)
              SettingsItemModel(
                title: loc.appLanguage,
                icon: AssetsManager.globe,
                onTap: () {
                  Navigator.pushNamed(context, RoutesManager.appLanguageView);
                },
              ),

              /// FAQ (allowed for guest)
              SettingsItemModel(
                title: loc.faq,
                icon: AssetsManager.questions,
                onTap: () {
                  Navigator.pushNamed(context, RoutesManager.faqView);
                },
              ),

              /// Terms (allowed for guest)
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
              if (!isGuest)
                /// Logout
                SettingsItemModel(
                  title: loc.logout,
                  icon: AssetsManager.logout,
                  type: SettingsTileType.logout,
                  onTap: () {
                    if (isGuest) {
                      _showGuestMessage(context, loc);
                      return;
                    }

                    showConfirmationDialog(
                      context: context,
                      confirmText: loc.yes,
                      cancelText: loc.no,
                      title: loc.logout,
                      message: loc.logoutMessage,
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
            ],
          ),
          if (isGuest)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: RS.size(context, 50),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  border: Border.all(color: ColorsManager.primaryColor),
                  borderRadius: BorderRadius.circular(RS.radius(context, 12)),
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
        ],
      ),
    );
  }
}
