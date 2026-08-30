import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/enums/request_priority.dart';
import 'package:meayar_alitqan/core/helper/responsive_size.dart';
import 'package:meayar_alitqan/core/utils/colors_manager.dart';
import 'package:meayar_alitqan/features/orders/customer/presentation/manager/create_order_view_model/create_order_view_model.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/order_summary_pricing_card.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/service_request_submit_section.dart';

import '../../../../../l10n/app_localizations.dart';
import '../order_summary_details_card.dart';

/// Step 4: read-only summary + the original submit logic (untouched),
/// with an "edit" link that jumps to [ServiceRequestEditStep].
class ServiceRequestConfirmationStep extends StatelessWidget {
  const ServiceRequestConfirmationStep({
    super.key,
    required this.mainCategoryId,
    required this.categoryId,
    required this.subserviceId,
    required this.title,
    required this.orderVM,
    required this.selectedPriority,
    required this.onEdit,
  });

  final String? mainCategoryId;
  final String? categoryId;
  final String? subserviceId;
  final String? title;
  final CreateOrderViewModel orderVM;
  final RequestPriority selectedPriority;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
          final loc = AppLocalizations.of(context)!;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loc.submitRequest,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: RS.font(context, 20),
                    color: ColorsManager.primaryTextDarkColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
                  child: OrderSummaryDetailsCard(
                    title: title,
                    location: orderVM.locationAreaController.text.trim(),
                    locationDetails: orderVM.locationDetailsController.text.trim(),
                    description: orderVM.descriptionController.text.trim(),
                    priority: selectedPriority,
                    scheduledDate: orderVM.scheduledDate,
                    imagesCount: orderVM.uploadedImages.length,
                  ),
                ),
                SizedBox(height: RS.size(context, 16)),
                const OrderSummaryPricingCard(),
                SizedBox(height: RS.size(context, 50)),
              ],
            ),
          ),
        ),

        /// ================= SUBMIT (original logic, unchanged) =================
        ServiceRequestSubmitSection(
          mainCategoryId: mainCategoryId,
          categoryId: categoryId,
          subserviceId: subserviceId,
          title: title,
          locationUrl: orderVM.locationUrlController.text.trim(),
          location: orderVM.locationAreaController.text.trim(),
          locationDetails: orderVM.locationDetailsController.text.trim(),
        ),

        Padding(
          padding: EdgeInsets.symmetric(vertical: RS.size(context, 4)),
          child: TextButton(
            onPressed: onEdit,
            child: Text(
              loc.editOrder,
              style: TextStyle(
                color: ColorsManager.primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: RS.font(context, 18),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
