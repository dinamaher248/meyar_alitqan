import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/core/components/custom_button.dart';
import 'package:meayar_alitqan/core/components/custom_text_field.dart';
import 'package:meayar_alitqan/core/helper/responsive_size.dart';
import 'package:meayar_alitqan/core/utils/colors_manager.dart';
import 'package:meayar_alitqan/features/location/presentation/manager/get_service_areas_view_model/get_service_areas_view_model.dart';
import 'package:meayar_alitqan/features/location/presentation/manager/get_service_areas_view_model/get_service_areas_view_model_states.dart';
import 'package:meayar_alitqan/features/orders/customer/presentation/manager/create_order_view_model/create_order_view_model.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/service_request_description_section.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/service_request_images_section.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/show_locations_sheet.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

import '../location_picker_field.dart';
import '../service_category_picker_field.dart';

/// Step 1: order details (category, description, location, images).
/// Validation still happens against [orderVM.formKey] in the parent -
/// this widget only renders the fields and reports "continue" taps.
class ServiceRequestDetailsStep extends StatelessWidget {
  const ServiceRequestDetailsStep({
    super.key,
    required this.categoryId,
    required this.orderVM,
    required this.onContinue,
  });

  final String? categoryId;
  final CreateOrderViewModel orderVM;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final loc= AppLocalizations.of(context)!;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loc.requestDetails,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: RS.font(context, 20),
                    fontWeight: FontWeight.w600,
                    color: ColorsManager.primaryTextDarkColor,
                  ),
                ),
                const SizedBox(height: 16),
                ServiceCategoryPickerField(
                  label: loc.orderSection,
                  initialCategoryId: categoryId,
                  onChanged: (category) {
                    orderVM.setSelectedCategory(category.id);
                  },
                ),
                const SizedBox(height: 24),

                const ServiceRequestDescriptionSection(),
                const SizedBox(height: 24),

                Text(
                  loc.location,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: RS.font(context, 16),
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.primaryTextDarkColor,
                  ),
                ),
                const SizedBox(height: 8),
                BlocBuilder<GetServiceAreasViewModel, GetServiceAreasViewModelStates>(
                  builder: (context, state) {
                    if (state is GetServiceAreasViewModelSuccess) {
                      return LocationPickerField(
                        hintText: loc.locationHint,
                        controller: orderVM.locationAreaController,
                        onTap: () => showLocationsSheet(context, state.serviceAreas),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return loc.invalidLocation;
                          }
                          return null;
                        },
                      );
                    }

                    if (state is GetServiceAreasViewModelLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is GetServiceAreasViewModelError) {
                      return Text(
                        state.message,
                        style: TextStyle(fontSize: RS.font(context, 14)),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),

                const SizedBox(height: 24),

                Text(
                  loc.locationDescription,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: RS.font(context, 16),
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.primaryTextDarkColor,
                  ),
                ),
                const SizedBox(height: 8),

                CustomTextFormField(
                  textEditingController: orderVM.locationDetailsController,
                  hintText: loc.locationDescriptionHint,
                  maxLines: 2,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return loc.invalidLocation;
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),
                const ServiceRequestImagesSection(),
                const SizedBox(height: 16),
              ],
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
            text: loc.onboardingContinue,
            onPressed: onContinue,
          ),
        ),
      ],
    );
  }
}
