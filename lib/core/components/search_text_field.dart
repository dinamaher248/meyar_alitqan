import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../helper/responsive_size.dart';
import '../utils/assets_manager.dart';
import '../utils/colors_manager.dart';

class SearchTextField extends StatelessWidget {
  final VoidCallback? onTap;
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;

  const SearchTextField({
    super.key,
    this.onTap,
    this.hintText = "",
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTap: onTap,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: RS.font(context, 13),
          fontWeight: FontWeight.w500,
          color: ColorsManager.secondaryTextDarkColor,
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: RS.size(context, 12)),
          child: SvgPicture.asset(
            AssetsManager.search,
            width: RS.size(context, 18),
            height: RS.size(context, 18),
            fit: BoxFit.scaleDown,
            color: ColorsManager.secondaryTextDarkColor,
          ),
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: RS.size(context, 18),
          minHeight: RS.size(context, 18),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RS.radius(context, 30)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RS.radius(context, 30)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RS.radius(context, 30)),
          borderSide: BorderSide(
            color: ColorsManager.primaryColor,
            width: RS.size(context, 1.5),
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          vertical: RS.size(context, 14),
          horizontal: RS.size(context, 16),
        ),
        isDense: true,
      ),
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontSize: RS.font(context, 13),
        fontWeight: FontWeight.w500,
        color: ColorsManager.black,
      ),
    );
  }
}