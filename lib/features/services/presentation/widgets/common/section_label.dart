import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/helper/responsive_size.dart';
import 'package:meayar_alitqan/core/utils/colors_manager.dart';

/// Small bold label used above form sections (location, date, priority, etc).
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: RS.size(context, 8)),
      child: Text(
        text,
        style: TextStyle(
          fontSize: RS.font(context, 14),
          fontWeight: FontWeight.w600,
          color: ColorsManager.primaryTextDarkColor,
        ),
      ),
    );
  }
}
