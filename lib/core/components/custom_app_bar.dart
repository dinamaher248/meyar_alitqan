import 'package:flutter/material.dart';

import '../helper/responsive_size.dart';
import '../utils/colors_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool centerTitle;
  final bool showBackButton;
  final VoidCallback? onBack;
  final bool showWatch;
  final String watchCount;

  const CustomAppBar({
    super.key,
    this.title,
    this.centerTitle = false,
    this.showBackButton = true,
    this.onBack,
    this.showWatch = false,
    this.watchCount = "0",
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
       backgroundColor: ColorsManager.lightGrey,
      elevation: 0,
      centerTitle: centerTitle,

      actions: [
        if (showWatch)
          Padding(
            padding: EdgeInsets.only(left: RS.size(context, 16)),
            child: Row(
              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.remove_red_eye,
                  color: ColorsManager.primaryColor,
                  size: RS.size(context, 20),
                ),
                SizedBox(width: RS.size(context, 4)),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    watchCount,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorsManager.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: RS.font(context, 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],

      leading: showBackButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: ColorsManager.primaryColor,
                size: RS.size(context, 20),
              ),
              onPressed: onBack ?? () => Navigator.pop(context),
            )
          : null,

      title: Text(
        title ?? "",
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: ColorsManager.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: RS.font(context, 18),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
