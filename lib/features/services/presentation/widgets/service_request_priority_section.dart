import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/core/di/di.dart';
import 'package:meayar_alitqan/features/services/presentation/manager/get_request_priority_view_model/get_request_priority_view_model.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/request_priority_section.dart';

import '../../../../core/enums/request_priority.dart';

class ServiceRequestPrioritySection extends StatelessWidget {
  const ServiceRequestPrioritySection({
    super.key,
    required this.selectedPriority,
    required this.onChanged,
  });

  final RequestPriority selectedPriority;
  final ValueChanged<RequestPriority> onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>  getIt<GetRequestPriorityViewModel>()..getRequestPriority(),
      child: RequestPrioritySection(
        selectedPriority: selectedPriority,
        onChanged: onChanged,
      ),
    );
  }
}
