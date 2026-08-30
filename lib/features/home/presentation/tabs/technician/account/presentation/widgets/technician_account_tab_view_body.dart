import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../../../config/routes/routes_manager.dart';
import '../../../../../../../../core/components/confirmation_dialog.dart';
import '../../../../../../../../core/cubit/app_user/app_user_cubit.dart';
import '../../../../../../../../core/helper/responsive_size.dart';
import '../../../../../../../../core/services/avatar_upload_service.dart';
import '../../../../../../../../core/services/secure_storage_service.dart';
import '../../../../../../../../core/utils/assets_manager.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../../profile/shared/domain/entities/settings_Item_model/settings_Item_model.dart';
import '../../../../../../../profile/shared/presentation/widgets/app_language_view_body.dart';
import '../../../../../../../profile/shared/presentation/widgets/settings_list.dart';
import '../../../../../../../profile/shared/presentation/widgets/show_avatar_picker_sheet.dart';
import '../../../../../../../profile/shared/presentation/widgets/user_profile_avatar.dart';
import '../../../../../../../profile/techinican/presentation/manager/update_techinican_profile_view_model/update_technician_profile_view_model.dart';

class TechnicianAccountTabViewBody extends StatelessWidget {
  const TechnicianAccountTabViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppUserCubit>().state;
    final avatarService = AvatarUploadService();

    return SingleChildScrollView(
      child: Column(
        children: [
          // Container(
          //   height: RS.size(context, 30),
          //   color: ColorsManager.primaryColor.withOpacity(.1),
          // ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: RS.size(context, 10.0)),
            child: UserProfileAvatar(
              rating: user?.rating,
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
                          .read<UpdateTechnicianProfileViewModel>()
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
                          .read<UpdateTechnicianProfileViewModel>()
                          .updateProfile(avatar: url);
                    }
                  },
                );
              },
            ),
          ),
          SizedBox(height: RS.size(context, 16)),
          SettingsList(
            items: [
              SettingsItemModel(
                title: AppLocalizations.of(context)!.accountSettings,
                icon: AssetsManager.settings,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RoutesManager.accountSettingsView,
                  );
                },
              ),
              SettingsItemModel(
                title: AppLocalizations.of(context)!.reports,
                icon: AssetsManager.reports,
                onTap: () {
                  Navigator.pushNamed(context, RoutesManager.reportView);
                },
              ),
              SettingsItemModel(
                title: AppLocalizations.of(context)!.appLanguage,
                icon: AssetsManager.globe,
                onTap: () {
                  showLanguagePickerSheet(context);
                },
                // onTap: () {
                //   Navigator.pushNamed(context, RoutesManager.appLanguageView);
                // },
              ),

              SettingsItemModel(
                title: AppLocalizations.of(context)!.termsAndConditions,
                icon: AssetsManager.work,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RoutesManager.termsAndConditionsView,
                  );
                },
              ),
              SettingsItemModel(
                title: AppLocalizations.of(context)!.contactUs,
                icon: AssetsManager.customerService,
                onTap: () {
                  Navigator.pushNamed(context, RoutesManager.contactUs);
                },
              ),

              SettingsItemModel(
                title: AppLocalizations.of(context)!.logout,
                icon: AssetsManager.logout,
                type: SettingsTileType.logout,
                onTap: () {
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
                        RoutesManager.splash,
                        (_) => false,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
