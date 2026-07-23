import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meayar_alitqan/core/components/custom_success_bottom_sheet.dart';
import 'package:meayar_alitqan/core/services/whatsapp_service.dart';
import 'package:meayar_alitqan/features/location/presentation/manager/get_service_areas_view_model/get_service_areas_view_model.dart';
import 'package:meayar_alitqan/features/location/presentation/manager/get_service_areas_view_model/get_service_areas_view_model_states.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/show_locations_sheet.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/show_web_data_picker.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/video_call_info_section.dart';

import '../../../../core/components/custom_button.dart';
import '../../../../core/components/custom_text_field.dart';
import '../../../../core/enums/request_priority.dart';
import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/colors_manager.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../location/presentation/manager/get_current_location_view_model/get_current_location_view_model.dart';
import '../../../orders/customer/presentation/manager/create_order_view_model/create_order_view_model.dart';
import '../../../orders/customer/presentation/manager/create_order_view_model/create_order_view_model_states.dart';

import '../../../location/presentation/manager/get_current_location_view_model/get_current_location_view_model_states.dart';

import '../widgets/service_request_description_section.dart';
import '../widgets/service_request_images_section.dart';
import '../widgets/service_request_priority_section.dart';
import '../widgets/service_request_scheduled_date_section.dart';
import '../widgets/service_request_submit_section.dart';
import '../widgets/service_request_video_section.dart';
import 'location_picker_field.dart';

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

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final orderVM = context.read<CreateOrderViewModel>();
    final locationVM = context.read<GetCurrentUserLocationViewModel>();

    return SafeArea(
      child: MultiBlocListener(
        listeners: [
          /// ================= CREATE ORDER =================
          BlocListener<CreateOrderViewModel, CreateOrderViewModelStates>(
            listener: (context, state) {
              if (state is CreateOrderViewModelSuccess) {
                CustomSuccessBottomSheet(context: context, t: t ,  );
              }
            },
          ),

          /// ================= LOCATION RESULT =================
          BlocListener<
            GetCurrentUserLocationViewModel,
            GetCurrentUserLocationViewModelStates
          >(
            listener: (context, state) {
              if (state is GetCurrentUserLocationViewModelSuccess) {
                final loc = state.userLocationEntity;
                orderVM.locationUrlController.text =
                    'https://www.google.com/maps?q=${loc.latitude},${loc.longitude}';
              }

              if (state is GetCurrentUserLocationViewModelError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
        ],
        child: _buildForm(context, t, orderVM, locationVM),
      ),
    );
  }

  // ================= FORM =================
  Widget _buildForm(
    BuildContext context,
    AppLocalizations t,
    CreateOrderViewModel orderVM,
    GetCurrentUserLocationViewModel locationVM,
  ) {
    return Form(
      key: orderVM.formKey,
      autovalidateMode: orderVM.autovalidateMode,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ServiceRequestDescriptionSection(),
                  const SizedBox(height: 24),

                  Text(
                    t.location,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: RS.font(context, 16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  BlocBuilder<
                    GetServiceAreasViewModel,
                    GetServiceAreasViewModelStates
                  >(
                    builder: (context, state) {
                      if (state is GetServiceAreasViewModelSuccess) {
                        return LocationPickerField(
                          hintText: t.locationHint,
                          controller: orderVM.locationAreaController,
                          onTap: () =>
                              showLocationsSheet(context, state.serviceAreas),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return t.invalidLocation;
                            }
                            return null;
                          },
                        );
                      }

                      if (state is GetServiceAreasViewModelLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is GetServiceAreasViewModelError) {
                        return Text(state.message,
                            style: TextStyle(

                              fontSize: RS.font(context, 14),
                            ));
                      }

                      return const SizedBox.shrink();
                    },
                  ),

                  const SizedBox(height: 24),

                  Text(
                    t.locationDescription,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: RS.font(context, 16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  CustomTextFormField(
                    textEditingController: orderVM.locationDetailsController,
                    hintText: t.locationDescriptionHint,
                    maxLines: 2,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return t.invalidLocation;
                      }
                      return null;
                    },
                  ),

                  /// ================= LOCATION =================
                  // Text(
                  //   t.yourLocation,
                  //   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  //     fontSize: RS.font(context, 16),
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // const SizedBox(height: 8),
                  //
                  // /// Location field (optional – read only)
                  // CustomTextFormField(
                  //   textEditingController: orderVM.locationUrl,
                  //   hintText: t.location,
                  //   maxLines: 2,
                  //   isEnable: false,
                  // ),

                  // const SizedBox(height: 8),

                  // BlocBuilder<
                  //   GetCurrentUserLocationViewModel,
                  //   GetCurrentUserLocationViewModelStates
                  // >(
                  //   builder: (context, state) {
                  //     final isLoading =
                  //         state is GetCurrentUserLocationViewModelLoading;

                  //     return Center(
                  //       child: ConstrainedBox(
                  //         constraints: BoxConstraints(maxWidth: 400),
                  //         child: SizedBox(
                  //           width: double.infinity,
                  //           child: ElevatedButton.icon(
                  //             icon: isLoading
                  //                 ? const SizedBox(
                  //                     width: 18,
                  //                     height: 18,
                  //                     child: CircularProgressIndicator(
                  //                       strokeWidth: 2,
                  //                       color: Colors.white,
                  //                     ),
                  //                   )
                  //                 : const Icon(
                  //                     Icons.my_location,
                  //                     color: Colors.white,
                  //                   ),
                  //             label: Text(
                  //               t.useMyLocation,
                  //               style: Theme.of(context).textTheme.bodyLarge
                  //                   ?.copyWith(
                  //                     color: Colors.white,
                  //                     fontWeight: FontWeight.bold,
                  //                     fontSize: RS.font(context, 14),
                  //                   ),
                  //             ),
                  //             style: ElevatedButton.styleFrom(
                  //               backgroundColor: ColorsManager.primaryColor,
                  //               padding: const EdgeInsets.symmetric(
                  //                 vertical: 14,
                  //               ),
                  //               shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(8),
                  //               ),
                  //             ),
                  //             onPressed: isLoading
                  //                 ? null
                  //                 : () {
                  //                     locationVM.getCurrentUserLocation();
                  //                   },
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                  const SizedBox(height: 24),

                  const ServiceRequestImagesSection(),
                  const SizedBox(height: 24),

                  ServiceRequestPrioritySection(
                    selectedPriority: selectedPriority,
                    onChanged: (value) {
                      setState(() {
                        selectedPriority = value;
                        orderVM.selectedPriority = value;
                        if (value != RequestPriority.scheduled) {
                          orderVM.setScheduledDate(null);
                        }
                      });
                    },
                  ),

                  if (selectedPriority == RequestPriority.scheduled) ...[
                    const SizedBox(height: 24),
                    ServiceRequestScheduledDateSection(
                      selectedDate: orderVM.scheduledDate,
                      onSelectDate: () async {
                        final date = kIsWeb
                            ? await showWebDatePicker(
                                context,
                                initialDate:
                                    orderVM.scheduledDate ?? DateTime.now(),
                              )
                            : await showDatePicker(
                                context: context,
                                initialDate:
                                    orderVM.scheduledDate ?? DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(
                                  const Duration(days: 30),
                                ),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: ColorsManager.primaryColor,
                                        onPrimary: Colors.white,
                                        onSurface: ColorsManager.primaryColor,
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor:
                                              ColorsManager.primaryColor,
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                        if (date != null) {
                          setState(() {
                            orderVM.setScheduledDate(date);
                          });
                        }

                        if (date != null) {
                          setState(() {
                            orderVM.setScheduledDate(date);
                          });
                        }
                      },
                    ),
                  ],

                  const SizedBox(height: 24),
                  const ServiceRequestVideoSection(),
                  const SizedBox(height: 24),

                  VideoCallInfoSection(
                    onRequestVideoCall: () {
                      WhatsAppService.openChat(
                        phone: '+962781319003',
                        message:
                            'مرحبا اريد اجراء مكالمه فيديو  عاجله معك الان',
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          const Divider(),

          /// ================= SUBMIT =================
          ServiceRequestSubmitSection(
            mainCategoryId: widget.mainCategoryId,
            categoryId: widget.categoryId,
            subserviceId: widget.subserviceId,
            title: widget.title,
            locationUrl: orderVM.locationUrlController.text.trim(),
            location: orderVM.locationAreaController.text.trim(),
            locationDetails: orderVM.locationDetailsController.text.trim(),
          ),
        ],
      ),
    );
  }

 
 
}
