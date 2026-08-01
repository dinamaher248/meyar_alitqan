import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/components/custom_button.dart';
import 'package:meayar_alitqan/core/enums/request_priority.dart';
import 'package:meayar_alitqan/core/helper/responsive_size.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/service_request_priority_section.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

/// Step 2: request priority (scheduled / urgent / emergency).
class ServiceRequestPriorityStep extends StatelessWidget {
  const ServiceRequestPriorityStep({
    super.key,
    required this.selectedPriority,
    required this.onPriorityChanged,
    required this.onContinue,
  });

  final RequestPriority selectedPriority;
  final ValueChanged<RequestPriority> onPriorityChanged;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ServiceRequestPrioritySection(
              selectedPriority: selectedPriority,
              onChanged: onPriorityChanged,
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
