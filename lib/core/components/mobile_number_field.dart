import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

import '../utils/colors_manager.dart';

class MobileNumberField extends StatefulWidget {
  const MobileNumberField({
    super.key,
    required this.controller,
    this.hintText = '',
    this.validator,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  /// بيرجع الرقم كامل +الكود
  final Function(String fullPhone)? onChanged;

  @override
  State<MobileNumberField> createState() => _MobileNumberFieldState();
}

class _MobileNumberFieldState extends State<MobileNumberField> {
  Country _country = Country.parse('JO');

  /// الرقم بدون كود (للعرض فقط)
  String _localNumber = '';

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      validator: widget.validator,
      style: const TextStyle(fontSize: 13),

      /// ⚠️ controller بيشيل الرقم كامل (مش اللي ظاهر)
      controller: TextEditingController(text: _localNumber),

      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(fontSize: 12),

        /// ===== كود الدولة (UI فقط) =====
        prefixIcon: InkWell(
          onTap: () => _openCountryPicker(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 8),
              Text(
                _country.flagEmoji,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 4),
              Text(
                '+${_country.phoneCode}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.arrow_drop_down, size: 18),
              const SizedBox(width: 6),
            ],
          ),
        ),

        prefixIconConstraints: const BoxConstraints(
          minWidth: 0,
          minHeight: 0,
        ),

        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: ColorsManager.primaryColor,
            width: 1.5,
          ),
        ),
      ),

      /// ===== المستخدم يكتب الرقم فقط =====
      onChanged: (value) {
        _localNumber = value;

        final fullPhone = '+${_country.phoneCode}$_localNumber';

        /// نخزن الرقم الكامل في الكنترولر الحقيقي
        widget.controller.text = fullPhone;

        widget.onChanged?.call(fullPhone);
      },
    );
  }

  /// ===================== COUNTRY PICKER =====================
  void _openCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      showSearch: true,
      onSelect: (Country country) {
        setState(() => _country = country);

        /// تحديث الرقم الكامل مع الكود الجديد
        final fullPhone = '+${country.phoneCode}$_localNumber';
        widget.controller.text = fullPhone;

        widget.onChanged?.call(fullPhone);
      },
    );
  }
}
