import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/custom_text_field.dart';
import '../../../../core/helper/responsive_size.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../orders/customer/presentation/manager/create_order_view_model/create_order_view_model.dart';

class ServiceRequestDescriptionSection extends StatelessWidget {
  const ServiceRequestDescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final vm = context.read<CreateOrderViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.addServiceRequestDetails,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: RS.font(context, 16),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: RS.size(context, 10)),
        CustomTextFormField(
          textEditingController: vm.descriptionController,
          hintText: t.writeRequestDetailsHint,
          maxLines: 7,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return t.problemDescriptionValidation;
            }
            if (value.trim().length < 10) {
              return t.problemDescriptionValidation;
            }
            return null;
          },
        ),
      ],
    );
  }
}
