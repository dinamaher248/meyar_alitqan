import 'package:flutter/material.dart';
import '../helper/responsive_size.dart';
import '../utils/colors_manager.dart';
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.maxWidth,
    this.height,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final double? maxWidth;
  final double? height;
  final bool isLoading;

  bool get isEnabled => onPressed != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? RS.size(context, 420),
        ),
        child: GestureDetector(
          
          onTap: isEnabled ? onPressed : null,
          child: Opacity(
            opacity: isEnabled ? 1.0 : 0.6,
            child: Container(
              height: height ?? RS.size(context, 50),
              width: double.infinity,
              decoration: BoxDecoration(
                color: isEnabled
                    ? ColorsManager.primaryColor
                    : Colors.grey,
                borderRadius: BorderRadius.circular(
                  RS.radius(context, 14),
                ),
              ),
              alignment: Alignment.center,
              child: isLoading
                  ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
                  : Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: RS.font(context, 16),
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
