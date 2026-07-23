import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/helper/responsive_size.dart';
import 'package:meayar_alitqan/core/utils/colors_manager.dart';
Future<DateTime?> showWebDatePicker(
    BuildContext context, {
      required DateTime initialDate,
    }) {
  DateTime tempDate = initialDate;

  return showDialog<DateTime>(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          width: 360, // ✅ الحجم المناسب للويب
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// TITLE
                Text(
                  'Select date',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 12),

                Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: ColorsManager.primaryColor,
                      onPrimary: Colors.white,
                      onSurface: Colors.black,
                    ),

                    /// ✅ تصغير النصوص
                    textTheme: const TextTheme(
                      bodySmall: TextStyle(fontSize: 12),
                      bodyMedium: TextStyle(fontSize: 13),
                      labelLarge: TextStyle(fontSize: 13),
                    ),

                    /// ✅ تصغير الأيقونات (الأسهم)
                    iconTheme: const IconThemeData(
                      size: 18, // 👈 حجم السهم
                    ),

                    /// ✅ تقليل مساحة الضغط (كان سبب كبر السهم)
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: ButtonTheme(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: CalendarDatePicker(
                      initialDate: initialDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 30)),
                      onDateChanged: (date) {
                        tempDate = date;
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                const Divider(height: 1),

                const SizedBox(height: 8),

                /// ACTIONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () =>
                          Navigator.pop(context, tempDate),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        ColorsManager.primaryColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
