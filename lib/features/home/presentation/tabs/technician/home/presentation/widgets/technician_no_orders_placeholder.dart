import 'package:flutter/material.dart';

import '../../../../../../../../core/helper/responsive_size.dart';
import '../../../../../../../../core/utils/assets_manager.dart';
import '../../../../../../../../core/utils/colors_manager.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class TechnicianNoOrdersPlaceholder extends StatelessWidget {
  const TechnicianNoOrdersPlaceholder({super.key, this.onBrowse});

  final VoidCallback? onBrowse;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(RS.size(context, 20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(RS.radius(context, 14)),
        border: Border.all(color: ColorsManager.grey),
      ),
      child: Column(
        children: [
          Image.asset(
            AssetsManager.waiting,
            fit: BoxFit.cover,
            height: RS.size(context, 140),
          ),
          SizedBox(height: RS.size(context, 12)),
          Text(
            loc.noOrders,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: RS.font(context, 16),
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.primaryTextDarkColor,
                ),
          ),
          SizedBox(height: RS.size(context, 4)),
          Text(
            loc.noOrdersDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: RS.font(context, 12),
              color: ColorsManager.secondaryTextDarkColor,
            ),
          ),
          SizedBox(height: RS.size(context, 16)),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onBrowse,
              icon: Icon(Icons.description_outlined,
                  size: RS.size(context, 16), color: ColorsManager.primaryColor),
              label: Text(
                loc.browseNewOrders,
                style: TextStyle(
                  color: ColorsManager.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: RS.font(context, 13),
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: ColorsManager.primaryColor),
                padding: EdgeInsets.symmetric(vertical: RS.size(context, 12)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(RS.radius(context, 10)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}