import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/features/services/presentation/manager/get_request_priority_view_model/get_request_priority_view_model.dart';
import 'package:meayar_alitqan/features/services/presentation/manager/get_request_priority_view_model/get_request_priority_view_model_states.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/request_type_card.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

import '../../../../core/enums/request_priority.dart';
import '../../../../core/helper/responsive_size.dart';

class RequestPrioritySection extends StatelessWidget {
  final RequestPriority selectedPriority;
  final ValueChanged<RequestPriority> onChanged;

  const RequestPrioritySection({
    super.key,
    required this.selectedPriority,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.selectRequestType,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: RS.font(context, 16),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: RS.size(context, 10)),

        BlocBuilder<
          GetRequestPriorityViewModel,
          GetRequestPriorityViewModelStates
        >(
          builder: (context, state) {
            if (state is GetRequestPriorityViewModelLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetRequestPriorityViewModelSuccess) {
              int getPercentage(String type) {
                final list = state.requestPriorities;

                final index = list.indexWhere((e) => e.type == type);
                if (index == -1) return 0;

                return list[index].percentage;
              }

              return SizedBox(
                height: RS.size(context, 170),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    RequestTypeCard(
                      title: t.scheduled,
                      subtitle: t.scheduledSubtitle,
                      icon: Icons.schedule,
                      color: Colors.green,
                      badgeText: "+${getPercentage('scheduled')}%",
                      isSelected: selectedPriority == RequestPriority.scheduled,
                      onTap: () => onChanged(RequestPriority.scheduled),
                    ),
                    RequestTypeCard(
                      title: t.urgent,
                      subtitle: t.urgentSubtitle,
                      icon: Icons.flash_on,
                      color: Colors.orange,
                      badgeText: "+${getPercentage('urgent')}%",
                      isSelected: selectedPriority == RequestPriority.urgent,
                      onTap: () => onChanged(RequestPriority.urgent),
                    ),
                    RequestTypeCard(
                      title: t.emergency,
                      subtitle: t.emergencySubtitle,
                      icon: Icons.warning_amber_rounded,
                      color: Colors.red,
                      badgeText: "+${getPercentage('emergency')}%",
                      isSelected: selectedPriority == RequestPriority.emergency,
                      onTap: () => onChanged(RequestPriority.emergency),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
