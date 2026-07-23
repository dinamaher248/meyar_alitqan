import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/helper/responsive_size.dart';
import '../../../../../core/utils/colors_manager.dart';

class SocialLoginButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final VoidCallback? onPressed;
  final bool isLoading;

  const SocialLoginButton({
    super.key,
    required this.label,
    required this.iconPath,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: RS.size(context, 52),
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey.shade400, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RS.radius(context, 12)),
          ),
          backgroundColor: Colors.transparent,
        ),
        onPressed: isLoading ? null : onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                width: RS.size(context, 20),
                height: RS.size(context, 20),
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: ColorsManager.primaryColor,
                ),
              )
            else
              SvgPicture.asset(
                iconPath,
                width: RS.size(context, 20),
                height: RS.size(context, 20),
              ),

            SizedBox(width: RS.size(context, 12)),

            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: RS.font(context, 15),
                fontWeight: FontWeight.bold,
                color: isLoading
                    ? ColorsManager.black.withOpacity(0.6)
                    : ColorsManager.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
