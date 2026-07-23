import 'package:flutter/material.dart';
import 'package:meayar_alitqan/features/home/presentation/tabs/customer/account/presentation/views/customer_account_tab_view.dart';
import 'package:meayar_alitqan/features/home/presentation/tabs/customer/home/presentation/views/customer_home_tab_view.dart';
import 'package:meayar_alitqan/features/home/presentation/tabs/customer/orders/presentation/views/customer_orders_tab_view.dart';

 

final List<Widget> customerMobileTabs = [
  const CustomerHomeTabView(),
  const CustomerOrdersTabView(),
  const CustomerAccountTabView(),
];
