import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:lottie/lottie.dart';

import '../helper/responsive_size.dart';
import '../utils/assets_manager.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({
    super.key,
    this.size,
    this.backgroundColor,
  });

  final double? size;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final loaderSize = size ?? RS.size(context, 120);

    return AbsorbPointer(
      absorbing: true,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: backgroundColor ?? Colors.black.withOpacity(0.35),
        alignment: Alignment.center,

        /// 🔹 Web vs Mobile
        child: kIsWeb
            ? SizedBox(
          width: loaderSize / 2,
          height: loaderSize / 2,
          child: const CircularProgressIndicator(
            strokeWidth: 3,
            color: Colors.white,
          ),
        )
            : Lottie.asset(
          AssetsManager.loading,
          width: loaderSize,
          height: loaderSize,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
