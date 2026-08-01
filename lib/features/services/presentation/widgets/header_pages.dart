import 'package:flutter/material.dart';
import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';

class HeaderPages extends StatelessWidget {
  const HeaderPages({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: RS.size(context, 16),
        vertical: RS.size(context, 12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.chevron_left,
              color: ColorsManager.primaryTextDarkColor,
              size: RS.size(context, 22),
            ),
          ),
          Spacer(),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: RS.font(context, 20),
              color: ColorsManager.primaryTextDarkColor,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}