import 'package:flutter/material.dart';

import '../helper/responsive_size.dart';
import '../utils/colors_manager.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final IconData icon;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    required this.onCancel,
    this.confirmText = "نعم",
    this.cancelText = "لا",
    this.icon = Icons.logout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: RS.size(context, 24),
        vertical: RS.size(context, 28),
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// ===== Icon Circle =====
          Container(
            width: RS.size(context, 56),
            height: RS.size(context, 56),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red.withOpacity(0.1),
            ),
            child: Icon(
              icon,
              color: Colors.red,
              size: RS.size(context, 26),
            ),
          ),

          SizedBox(height: RS.size(context, 16)),

          Text(
            title,
            style: TextStyle(
              fontSize: RS.font(context, 17),
              fontWeight: FontWeight.bold,
              color: ColorsManager.primaryTextDarkColor,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: RS.size(context, 8)),

          Text(
            message,
            style: TextStyle(
              fontSize: RS.font(context, 13),
              color: ColorsManager.secondaryTextDarkColor,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: RS.size(context, 22)),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                    padding: EdgeInsets.symmetric(
                      vertical: RS.size(context, 14),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        RS.radius(context, 10),
                      ),
                    ),
                  ),
                  onPressed: onCancel,
                  child: Text(
                    cancelText,
                    style: TextStyle(
                      color: ColorsManager.primaryTextDarkColor,
                      fontSize: RS.font(context, 14),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: RS.size(context, 12)),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: EdgeInsets.symmetric(
                      vertical: RS.size(context, 14),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        RS.radius(context, 10),
                      ),
                    ),
                  ),
                  onPressed: onConfirm,
                  child: Text(
                    confirmText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: RS.font(context, 14),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<void> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String message,
  required VoidCallback onConfirm,
  VoidCallback? onCancel,
  String confirmText = "نعم",
  String cancelText = "لا",
  IconData icon = Icons.logout,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return ConfirmationDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        icon: icon,
        onConfirm: () {
          Navigator.of(context).pop();
          onConfirm();
        },
        onCancel: () {
          Navigator.of(context).pop();
          if (onCancel != null) onCancel();
        },
      );
    },
  );
}