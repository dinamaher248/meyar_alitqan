import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meayar_alitqan/core/helper/responsive_size.dart';

import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/utils/colors_manager.dart';
import '../../domain/entities/settings_Item_model/settings_Item_model.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.title,
    required this.icon,
    this.type = SettingsTileType.navigation,
    this.onTap,
    this.switchValue,
    this.onToggle,
  });

  final String title;
  final String icon;
  final SettingsTileType type;
  final VoidCallback? onTap;
  final bool? switchValue;
  final ValueChanged<bool>? onToggle;

  @override
  Widget build(BuildContext context) {
    final bool isLogout = type == SettingsTileType.logout;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: isLogout
            ? EdgeInsets.symmetric(
                vertical: RS.size(context, 10),
                horizontal: RS.size(context, 7),
              )
            : EdgeInsets.symmetric(
                vertical: RS.size(context, 3),
                horizontal: RS.size(context, 7),
              ),
        padding: EdgeInsets.symmetric(
          vertical: RS.size(context, 15),
          horizontal: RS.size(context, 7),
        ),
       
        child: Row(
          children: [
            // icon
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isLogout
                    ? Colors.red.withValues(alpha: .15)
                    : ColorsManager.primaryColor.withValues(alpha: .15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(
                icon,
                height: RS.size(context, 16),
                width: RS.size(context, 16),
                color: isLogout
                    ? Color(0xffC93000)
                    : ColorsManager.primaryColor,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: RS.font(context, 18),
                  color: isLogout
                      ? Color(0xffC93000)
                      : ColorsManager.primaryColor,
                ),
              ),
            ),

            if (type == SettingsTileType.navigation ||
                type == SettingsTileType.logout)
              _ArrowButton(isLogout: isLogout)
            else if (type == SettingsTileType.toggle)
              Switch(
                value: switchValue ?? false,
                onChanged: onToggle,
                activeThumbColor: ColorsManager.primaryColor,
              ),
          ],
        ),
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({required this.isLogout});

  final bool isLogout;

  @override
  Widget build(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    return Transform.rotate(
      angle: isRTL ? 3.1416 : 0,
      child: SvgPicture.asset(
        AssetsManager.angleRight,
        width: RS.size(context, 18),
        height: RS.size(context, 18),
        color: isLogout ? const Color(0xffC93000) : ColorsManager.primaryColor,
      ),
    );
  }
}
