import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/enums/request_priority.dart';
import 'package:meayar_alitqan/core/helper/responsive_size.dart';
import 'package:meayar_alitqan/core/utils/colors_manager.dart';

class PriorityRadioTile extends StatelessWidget {
  const PriorityRadioTile({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String label;
  final RequestPriority value;
  final RequestPriority groupValue;
  final ValueChanged<RequestPriority> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: RS.size(context, 4)),
        child: Row(
          children: [
            Radio<RequestPriority>(
              value: value,
              groupValue: groupValue,
              activeColor: ColorsManager.primaryColor,
              onChanged: (v) => onChanged(v!),
            ),
            Text(label, style: TextStyle(fontSize: RS.font(context, 13))),
          ],
        ),
      ),
    );
  }
}
