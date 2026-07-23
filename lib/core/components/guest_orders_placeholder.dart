import 'package:flutter/material.dart';
import 'package:meayar_alitqan/features/home/presentation/tabs/customer/orders/presentation/widgets/custom_orders_tab_bar.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../config/routes/routes_manager.dart';

class GuestOrdersPlaceholder extends StatefulWidget {
  const GuestOrdersPlaceholder({super.key});

  @override
  State<GuestOrdersPlaceholder> createState() => _GuestOrdersPlaceholderState();
}

class _GuestOrdersPlaceholderState extends State<GuestOrdersPlaceholder> {
  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
            SizedBox(height: RS.size(context, 16)),

          CustomOrdersTabBar(
            selectedIndex: selectedTab,
            onTabChanged: (index) {
              setState(() => selectedTab = index);
            },
          ),
            SizedBox(height: RS.size(context, 50)),

          Icon(
            Icons.lock_outline,
            size: RS.size(context, 80),
            color: ColorsManager.grey,
          ),
          SizedBox(height: RS.size(context, 16)),
          Text(
            loc.loginToViewOrders,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: RS.font(context, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: RS.size(context, 8)),
          Text(
            loc.loginToContinue,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
              fontSize: RS.font(context, 13),
            ),
          ),
          SizedBox(height: RS.size(context, 20)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.primaryColor,
              padding: EdgeInsets.symmetric(
                horizontal: RS.size(context, 32),
                vertical: RS.size(context, 12),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                RoutesManager.roleSelection,
         
              );
            },
            child: Text(loc.login, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 16) ),
          ),
        ],
      ),
    );
  }
}
