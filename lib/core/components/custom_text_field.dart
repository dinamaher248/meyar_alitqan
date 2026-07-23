import 'package:flutter/material.dart';

import '../helper/responsive_size.dart';
import '../utils/colors_manager.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    required this.hintText,
    this.iconShow = false,
    this.keyboardType,
    this.onSaved,
    this.validator,
    this.isEmailValidator = false,
    this.textEditingController,
    this.autovalidateMode,
    this.prefixIcon,
    this.isEnable = true,
    this.maxLines = 1,
    this.minLines,
    this.onChanged,

    /// NEW: floating label inside the field
    this.floatingLabel,
  });

  final String? hintText;
  final bool iconShow;
  final TextInputType? keyboardType;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final bool isEmailValidator;
  TextEditingController? textEditingController;
  AutovalidateMode? autovalidateMode;
  Widget? prefixIcon;
  bool isEnable;
  void Function(String?)? onChanged;

  final int? maxLines;
  final int? minLines;

  /// NEW
  final String? floatingLabel;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool iconVisible = false;

  @override
  Widget build(BuildContext context) {
    final fillColor = widget.isEnable
        ? ColorsManager.white
        : Colors.grey.shade300;

    final hintColor = widget.isEnable ? Colors.black54 : Colors.grey.shade600;
    final lines = widget.maxLines ?? 1;

    return TextFormField(
      onChanged: widget.onChanged,
      cursorColor: ColorsManager.primaryColor,

      enabled: widget.isEnable,
      style: TextStyle(
        color: widget.isEnable ? Colors.black : Colors.grey.shade600,
        fontSize: RS.font(context, 14),
        fontWeight: FontWeight.w400,
      ),
      autovalidateMode: widget.autovalidateMode,
      controller: widget.textEditingController,

      obscureText: widget.iconShow ? !iconVisible : false,

      minLines: widget.minLines ?? lines,
      maxLines: widget.maxLines,

      onSaved: widget.onSaved,
      validator: widget.validator,

      keyboardType: widget.keyboardType,

      decoration: InputDecoration(
 errorStyle: TextStyle(
    fontSize: RS.font(context, 12), // مناسب للويب
    color: Colors.red.shade600,
    fontWeight: FontWeight.w400,
    height: 1.2,
  ),
        labelText: widget.floatingLabel,
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: RS.font(context, 14),


        ),

        floatingLabelStyle: TextStyle(
          color: ColorsManager.primaryColor,
          fontSize: RS.font(context, 14),
          fontWeight: FontWeight.w600,

        ),

        fillColor: fillColor,
        filled: true,
        contentPadding: const EdgeInsets.all(16.0),

        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: hintColor,
          fontSize: RS.font(context, 14),
          fontWeight: FontWeight.w400,

        ),


        prefixIcon: widget.prefixIcon,
        prefixIconConstraints: BoxConstraints(
          minWidth: RS.size(context, 10),
          minHeight: RS.size(context, 10),
        ),

        suffixIcon: widget.iconShow
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    iconVisible = !iconVisible;
                  });
                },
                child: Icon(
                  iconVisible ? Icons.visibility : Icons.visibility_off,
                  color: const Color(0xFFC9CECF),
                ),
              )
            : null,

        border: buildBorder(Colors.grey),
        enabledBorder: buildBorder(Colors.grey),
        focusedBorder: buildBorder(ColorsManager.primaryColor),
        errorBorder: buildBorder(Colors.red),
        focusedErrorBorder: buildBorder(Colors.red),
      ),
    );
  }

  OutlineInputBorder buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color),
    );
  }
}
