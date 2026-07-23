import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/helper/responsive_size.dart';
import 'package:meayar_alitqan/core/utils/colors_manager.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

class ServiceRequestScheduledDateSection extends StatelessWidget {
  const ServiceRequestScheduledDateSection({
    super.key,
    required this.selectedDate,
    required this.onSelectDate,
  });

  final DateTime? selectedDate;
  final VoidCallback onSelectDate;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final bool hasDate = selectedDate != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.selectScheduledDate,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: RS.font(context, 16),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: RS.size(context, 12)),

        GestureDetector(
          onTap: onSelectDate,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: RS.size(context, 14),
              horizontal: RS.size(context, 12),
            ),
            decoration: BoxDecoration(
              color: hasDate
                  ? ColorsManager.primaryColor.withOpacity(0.08)
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: hasDate
                    ? ColorsManager.primaryColor
                    : Colors.grey.shade400,
                width: 1.2,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: RS.size(context, 18),
                  color: hasDate
                      ? ColorsManager.primaryColor
                      : Colors.grey,
                ),
                SizedBox(width: RS.size(context, 10)),

                Expanded(
                  child: Text(
                    hasDate
                        ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                        : t.chooseDate,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: hasDate
                          ? ColorsManager.primaryColor
                          : Colors.grey.shade600,
                      fontWeight:
                      hasDate ? FontWeight.w600 : FontWeight.normal,
                      fontSize: RS.font(context, 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
