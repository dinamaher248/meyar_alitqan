import 'package:flutter/material.dart';
import 'package:meayar_alitqan/config/routes/routes_manager.dart';
import 'package:meayar_alitqan/core/helper/responsive_size.dart';
import 'package:meayar_alitqan/core/utils/colors_manager.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

class GuestHomeHeader extends StatelessWidget {
  const GuestHomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final isWeb = MediaQuery.of(context).size.width > 900;

    final avatarSize = isWeb ? 28.0 : RS.size(context, 40);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorsManager.primaryColor.withOpacity(0.12),
              ),
              child: Icon(
                Icons.person_outline,
                size: avatarSize * 0.6,
                color: ColorsManager.primaryColor,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${loc.welcome} 👋',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: isWeb ? 12 : 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  loc.guest,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: isWeb ? 13 : 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),

        OutlinedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              RoutesManager.roleSelection,
            );
          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: ColorsManager.primaryColor),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            loc.login,
            style: TextStyle(
              fontSize: isWeb ? 13 : 14,
              fontWeight: FontWeight.w600,
              color: ColorsManager.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
