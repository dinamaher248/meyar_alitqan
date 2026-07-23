import 'package:flutter/cupertino.dart';

enum SettingsTileType {
  navigation,
  toggle,
  logout,
}

class SettingsItemModel {
  final String title;
  final String icon;
  final SettingsTileType type;
  final VoidCallback? onTap;
  final bool? switchValue;
  final ValueChanged<bool>? onToggle;

  SettingsItemModel({
    required this.title,
    required this.icon,
    this.type = SettingsTileType.navigation,
    this.onTap,
    this.switchValue,
    this.onToggle,
  });
}
