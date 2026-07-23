import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/routes/routes_manager.dart';
import '../../../../../../core/cubit/app_user/app_user_cubit.dart';
import '../../../../../../core/enums/web_home_tabs.dart';
import '../../../../../../core/utils/assets_manager.dart';
import '../../../../../../core/utils/colors_manager.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../tabs/shared/widgets/user_avatar_with_text_row.dart';
import 'customer_web_tabs.dart';
import 'customer_web_mobile_menu.dart';

class CustomerWebHeader extends StatelessWidget {
  final bool isMobileWeb;
  final List<MapEntry<WebHomeTab, String>> tabs;
  final WebHomeTab currentTab;
  final ValueChanged<WebHomeTab> onTabChange;

  const CustomerWebHeader({
    super.key,
    required this.isMobileWeb,
    required this.tabs,
    required this.currentTab,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final user = context.watch<AppUserCubit>().state;

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
          SizedBox(width: 16  ,),

          if (!isMobileWeb)
            Expanded(
              child: CustomerWebTabs(
                tabs: tabs,
                currentTab: currentTab,
                onSelect: onTabChange,
              ),
            )
          else
            CustomerWebMobileMenu(tabs: tabs, onSelect: onTabChange),

          const SizedBox(width: 16),

          user == null
              ? TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesManager.roleSelection);
                  },
                  child: Text(
                    loc.loginOrRegister,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesManager.accountSettingsView,
                    );
                  },
                  child: UserAvatarWithTextRow(
                    name: user.fullName,
                    role: user.role,
                    avatar: user.avatarUrl ?? "",
                    showImageOnly: true,
                  ),
                ),
        ],
      ),
    );
  }
}
