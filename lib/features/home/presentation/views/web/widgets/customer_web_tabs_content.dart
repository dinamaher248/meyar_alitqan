import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/enums/web_home_tabs.dart';
import 'package:meayar_alitqan/features/home/presentation/tabs/customer/home/presentation/views/customer_home_tab_view.dart';
import 'package:meayar_alitqan/features/home/presentation/tabs/customer/home/presentation/widgets/web_about_section.dart';
import 'package:meayar_alitqan/features/home/presentation/tabs/customer/orders/presentation/views/customer_orders_tab_view.dart';
import 'package:meayar_alitqan/features/home/presentation/tabs/shared/widgets/contact_us_web_view.dart';
 

final Map<WebHomeTab, Widget> customerWebTabsContent = {
  WebHomeTab.home: const CustomerHomeTabView(),
  WebHomeTab.orders: const CustomerOrdersTabView(),
  WebHomeTab.about: const WebAboutSection(),
  WebHomeTab.contactUs: const ContactUsWebPage(),
};
