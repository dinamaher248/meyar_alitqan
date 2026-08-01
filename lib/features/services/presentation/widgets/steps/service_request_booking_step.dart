import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/components/custom_button.dart';
import 'package:meayar_alitqan/core/helper/responsive_size.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/inline_date_time_picker.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

/// Step 3: date/time picker, only shown for scheduled requests.
class ServiceRequestBookingStep extends StatelessWidget {
  const ServiceRequestBookingStep({
    super.key,
    required this.scheduledDate,
    required this.onDateChanged,
    required this.onContinue,
  });

  final DateTime? scheduledDate;
  final ValueChanged<DateTime?> onDateChanged;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: InlineDateTimePicker(
              selectedDateTime: scheduledDate,
              onChanged: onDateChanged,
            ),
          ),
        ),
        const Divider(),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: RS.size(context, 16),
            vertical: RS.size(context, 10),
          ),
          child: CustomButton(
            text: t.onboardingContinue,
            onPressed: onContinue,
          ),
        ),
      ],
    );
  }
}
