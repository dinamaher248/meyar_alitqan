import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';

class LocationPickerField extends StatelessWidget {
  const LocationPickerField({
    super.key,
    required this.hintText,
    required this.onTap,
    this.icon = Icons.location_on,
    this.controller,
    this.validator,
  });

  final String hintText;
  final VoidCallback onTap;
  final IconData icon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final isWeb = kIsWeb;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: IgnorePointer(
        ignoring: true,
        child: TextFormField(
          controller: controller,
          validator: validator,
          readOnly: true,

          style: TextStyle(
            fontSize: isWeb ? 14 : RS.font(context, 14),
          ),
          decoration: InputDecoration(
            isDense: true,

            contentPadding: EdgeInsets.symmetric(
              vertical: isWeb ? 14 : RS.size(context, 12),
              horizontal: 12,
            ),

            prefixIcon: Icon(
              icon,
              color: ColorsManager.primaryColor,
              size: isWeb ? 18 : RS.font(context, 14),
            ),

            suffixIcon: Icon(
              CupertinoIcons.chevron_down,
              color: ColorsManager.primaryColor,
              size: isWeb ? 16 : RS.font(context, 14),
            ),

            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
              fontSize: isWeb ? 14 : RS.font(context, 14),
            ),

            /// ✅ حجم نص الـ validator
            errorStyle: TextStyle(
              fontSize: isWeb ? 12 : RS.font(context, 12),
              height: 1.2,
              color: Colors.red,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
                width: 1,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: ColorsManager.primaryColor,
                width: 1.6,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
          ),

        ),
      ),
    );
  }
}
