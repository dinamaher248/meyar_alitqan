import 'package:flutter/material.dart';
import '../../../../../../../core/utils/colors_manager.dart';

class BottomGradientOverlay extends StatelessWidget {
  const BottomGradientOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            ColorsManager.black.withOpacity(0.2),
            ColorsManager.black.withOpacity(0.5),
            ColorsManager.black.withOpacity(0.8),
            ColorsManager.black,
          ],
        ),
      ),
    );
  }
}
