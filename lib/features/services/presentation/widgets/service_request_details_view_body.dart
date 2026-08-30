import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/core/components/custom_success_bottom_sheet.dart';
import 'package:meayar_alitqan/core/components/dismissible_error_card.dart';
import 'package:meayar_alitqan/core/enums/request_priority.dart';
import 'package:meayar_alitqan/core/helper/responsive_size.dart';
import 'package:meayar_alitqan/features/location/presentation/manager/get_current_location_view_model/get_current_location_view_model.dart';
import 'package:meayar_alitqan/features/location/presentation/manager/get_current_location_view_model/get_current_location_view_model_states.dart';
import 'package:meayar_alitqan/features/orders/customer/presentation/manager/create_order_view_model/create_order_view_model.dart';
import 'package:meayar_alitqan/features/orders/customer/presentation/manager/create_order_view_model/create_order_view_model_states.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/order_stepper_header.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/steps/service_request_booking_step.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/steps/service_request_confirmation_step.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/steps/service_request_details_step.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/steps/service_request_edit_step.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/steps/service_request_priority_step.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

import 'header_pages.dart';

enum OrderStep { details, priority, booking, confirmation, edit }

class ServiceRequestDetailsBody extends StatefulWidget {
  const ServiceRequestDetailsBody({
    super.key,
    required this.mainCategoryId,
    required this.categoryId,
    required this.subserviceId,
    required this.title,
  });

  final String? mainCategoryId;
  final String? categoryId;
  final String? subserviceId;
  final String? title;

  @override
  State<ServiceRequestDetailsBody> createState() =>
      _ServiceRequestDetailsBodyState();
}

class _ServiceRequestDetailsBodyState extends State<ServiceRequestDetailsBody> {
  RequestPriority selectedPriority = RequestPriority.scheduled;
  OrderStep currentStep = OrderStep.details;

  int get _stepNumber {
    switch (currentStep) {
      case OrderStep.details:
        return 1;
      case OrderStep.priority:
        return 2;
      case OrderStep.booking:
        return 3;
      case OrderStep.confirmation:
      case OrderStep.edit:
        return 4;
    }
  }

  void _goToStep(OrderStep step) => setState(() => currentStep = step);

  void _onPriorityChanged(RequestPriority value, CreateOrderViewModel orderVM) {
    setState(() {
      selectedPriority = value;
      orderVM.selectedPriority = value;
      if (value != RequestPriority.scheduled) {
        orderVM.setScheduledDate(null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final orderVM = context.read<CreateOrderViewModel>();

    return SafeArea(
      child: MultiBlocListener(
        listeners: [
          /// ================= CREATE ORDER =================
          BlocListener<CreateOrderViewModel, CreateOrderViewModelStates>(
            listener: (context, state) {
              if (state is CreateOrderViewModelSuccess) {
                CustomSuccessBottomSheet(context: context, t: loc);
              }
            },
          ),

          /// ================= LOCATION RESULT =================
          BlocListener<GetCurrentUserLocationViewModel, GetCurrentUserLocationViewModelStates>(
            listener: (context, state) {
              if (state is GetCurrentUserLocationViewModelSuccess) {
                final loc = state.userLocationEntity;
                orderVM.locationUrlController.text =
                    'https://www.google.com/maps?q=${loc.latitude},${loc.longitude}';
              }

              if (state is GetCurrentUserLocationViewModelError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
          ),
        ],
        child: Form(
          key: orderVM.formKey,
          autovalidateMode: orderVM.autovalidateMode,
          child: Column(
            children: [
              HeaderPages(title: loc.createOrder),

              /// ===== Stepper Header =====
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: RS.size(context, 40),
                  vertical: RS.size(context, 12),
                ),
                child: OrderStepperHeader(
                  currentStep: _stepNumber,
                  stepLabels:  [loc.details, loc.orderType, loc.booking, loc.confirmation],
                ),
              ),

              Expanded(child: _buildStep(context, orderVM, loc)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(
    BuildContext context,
    CreateOrderViewModel orderVM,
    AppLocalizations t,
  ) {
    switch (currentStep) {
      case OrderStep.details:
        return ServiceRequestDetailsStep(
          categoryId: widget.categoryId,
          orderVM: orderVM,
          onContinue: () {
            if (orderVM.formKey.currentState?.validate() ?? false) {
              _goToStep(OrderStep.priority);
            }
          },
        );

      case OrderStep.priority:
        return ServiceRequestPriorityStep(
          selectedPriority: selectedPriority,
          onPriorityChanged: (value) => _onPriorityChanged(value, orderVM),
          onContinue: () {
            _goToStep(
              selectedPriority == RequestPriority.scheduled
                  ? OrderStep.booking
                  : OrderStep.confirmation,
            );
          },
        );

      case OrderStep.booking:
        return ServiceRequestBookingStep(
          scheduledDate: orderVM.scheduledDate,
          onDateChanged: (dateTime) => setState(() => orderVM.setScheduledDate(dateTime)),
          onContinue: () {
            if (orderVM.scheduledDate == null) {
              showTemporaryMessage(context, t.scheduledDateRequired, MessageType.error);
              return;
            }
            _goToStep(OrderStep.confirmation);
          },
        );

      case OrderStep.confirmation:
        return ServiceRequestConfirmationStep(
          mainCategoryId: widget.mainCategoryId,
          categoryId: widget.categoryId,
          subserviceId: widget.subserviceId,
          title: widget.title,
          orderVM: orderVM,
          selectedPriority: selectedPriority,
          onEdit: () => _goToStep(OrderStep.edit),
        );

      case OrderStep.edit:
        return ServiceRequestEditStep(
          title: widget.title,
          orderVM: orderVM,
          selectedPriority: selectedPriority,
          onPriorityChanged: (value) => _onPriorityChanged(value, orderVM),
          onSave: () => _goToStep(OrderStep.confirmation),
        );
    }
  }
}
