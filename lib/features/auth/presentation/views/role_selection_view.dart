import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/helper/responsive_size.dart';

import '../../../../core/utils/colors_manager.dart';
import '../widgets/role_selection_view_body.dart';

class RoleSelectionView extends StatelessWidget {
  const RoleSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kIsWeb
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: ColorsManager.primaryTextDarkColor,
                  size: RS.size(context, 24),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          : null,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorsManager.gradientStart,
              ColorsManager.gradientEnd,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const SafeArea(child: RoleSelectionViewBody()),
      ),
    );
  }
}