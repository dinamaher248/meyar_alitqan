import 'package:meayar_alitqan/core/enums/web_home_tabs.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

 

List<MapEntry<WebHomeTab, String>> buildCustomerWebTabs(
  AppLocalizations loc,
) {
  return [
    MapEntry(WebHomeTab.home, loc.home),
    MapEntry(WebHomeTab.orders, loc.orders),
    MapEntry(WebHomeTab.about, loc.aboutUs),
    MapEntry(WebHomeTab.contactUs, loc.contactUs),
  ];
}
