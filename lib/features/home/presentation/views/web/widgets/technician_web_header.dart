import 'package:flutter/material.dart';
import 'package:meayar_alitqan/config/routes/routes_manager.dart';
import 'package:meayar_alitqan/core/enums/technician_web_tab.dart';
import 'package:meayar_alitqan/core/utils/assets_manager.dart';
import 'package:meayar_alitqan/core/utils/colors_manager.dart';
import 'package:meayar_alitqan/features/home/presentation/tabs/shared/widgets/user_avatar_with_text_row.dart';
import 'package:meayar_alitqan/features/profile/shared/domain/entities/base_profile_entity/base_profile_entity.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

 
import 'technician_web_desktop_tabs.dart';
import 'technician_web_mobile_menu.dart';

class TechnicianWebHeader extends StatelessWidget {
  final bool isMobileWeb;
  final AppLocalizations loc;
  final BaseProfileEntity user;
  final TechnicianWebTab currentTab;
  final ValueChanged<TechnicianWebTab> onTabChanged;

  const TechnicianWebHeader({
    super.key,
    required this.isMobileWeb,
    required this.loc,
    required this.user,
    required this.currentTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isMobileWeb ? 64 : 80,
      padding: EdgeInsets.symmetric(horizontal: isMobileWeb ? 16 : 48),
      color: ColorsManager.primaryColor,
      child: Row(
        children: [
          Image.asset(
            AssetsManager.logoWithoutBackground,
            height: isMobileWeb ? 36 : 48,
          ),
          if (!isMobileWeb) ...[
            const SizedBox(width: 48),
            Expanded(
              child: TechnicianWebDesktopTabs(
                loc: loc,
                currentTab: currentTab,
                onChanged: onTabChanged,
              ),
            ),
          ] else ...[
            const Spacer(),
            TechnicianWebMobileMenu(
              loc: loc,
              onSelected: onTabChanged,
            ),
          ],
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              RoutesManager.accountSettingsView,
            ),
            child: UserAvatarWithTextRow(
              name: user.fullName,
              role: user.role,
              avatar: user.avatarUrl ?? '',
              showImageOnly: true,
            ),
          ),
        ],
      ),
    );
  }
}
