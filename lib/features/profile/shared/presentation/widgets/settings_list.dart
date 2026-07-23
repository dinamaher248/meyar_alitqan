import 'package:flutter/cupertino.dart';
import 'package:meayar_alitqan/features/profile/shared/presentation/widgets/settings_tile.dart';

import '../../domain/entities/settings_Item_model/settings_Item_model.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({
    super.key,
    required this.items,
  });

  final List<SettingsItemModel> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return SettingsTile(
          title: item.title,
          icon: item.icon,
          type: item.type,
          onTap: item.onTap,
          switchValue: item.switchValue,
          onToggle: item.onToggle,
        );
      },
    );
  }
}
