import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/core/components/custom_success_bottom_sheet.dart';
import 'package:meayar_alitqan/features/location/presentation/manager/get_service_areas_view_model/get_service_areas_view_model.dart';
import 'package:meayar_alitqan/features/location/presentation/manager/get_service_areas_view_model/get_service_areas_view_model_states.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/inline_date_time_picker.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/order_summary_pricing_card.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/show_locations_sheet.dart';

import '../../../../core/components/custom_button.dart';
import '../../../../core/components/custom_text_field.dart';
import '../../../../core/components/dismissible_error_card.dart';
import '../../../../core/enums/request_priority.dart';
import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../location/presentation/manager/get_current_location_view_model/get_current_location_view_model.dart';
import '../../../location/presentation/manager/get_current_location_view_model/get_current_location_view_model_states.dart';
import '../../../orders/customer/presentation/manager/create_order_view_model/create_order_view_model.dart';
import '../../../orders/customer/presentation/manager/create_order_view_model/create_order_view_model_states.dart';
import '../views/sub_categories_view.dart';
import '../widgets/order_stepper_header.dart';
import '../widgets/service_request_description_section.dart';
import '../widgets/service_request_images_section.dart';
import '../widgets/service_request_priority_section.dart';
import '../widgets/service_request_submit_section.dart';
import 'location_picker_field.dart';
import 'order_summary_details_card.dart';
import 'service_category_picker_field.dart';

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

  void _goToStep(OrderStep step) {
    setState(() => currentStep = step);
  }

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
                CustomSuccessBottomSheet(context: context, t: t);
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
        child: Form(
          key: orderVM.formKey,
           autovalidateMode: orderVM.autovalidateMode,
          child: Column(
            children: [
              HeaderPages(title: "انشاء طلب"),
          
              /// ===== Stepper Header =====
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: RS.size(context, 40),
                  vertical: RS.size(context, 12),
                ),
                child: OrderStepperHeader(
                  currentStep: _stepNumber,
                  stepLabels: const ["التفاصيل", "نوع الطلب", "الحجز", "التأكيد"],
                ),
              ),
          
              Expanded(
                child: switch (currentStep) {
                  OrderStep.details => _buildDetailsStep(context, t, orderVM),
                  OrderStep.priority => _buildPriorityStep(context, t, orderVM),
                  OrderStep.booking => _buildBookingStep(context, t, orderVM),
                  OrderStep.confirmation => _buildConfirmationStep(
                    context,
                    t,
                    orderVM,
                  ),
                  OrderStep.edit => _buildEditStep(context, t, orderVM),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= STEP 1: التفاصيل =================
  Widget _buildDetailsStep(
    BuildContext context,
    AppLocalizations t,
    CreateOrderViewModel orderVM,
  ) {
    return Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "تفاصيل الطلب",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: RS.font(context, 20),
                      fontWeight: FontWeight.w600,
                      color: ColorsManager.primaryTextDarkColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  ServiceCategoryPickerField(
                    label: "قسم الطلب",
                    initialCategoryId: widget.categoryId,
                    onChanged: (category) {
                      orderVM.setSelectedCategory(category.id);
                    },
                  ),
                  const SizedBox(height: 24),

                  const ServiceRequestDescriptionSection(),
                  const SizedBox(height: 24),

                  Text(
                    t.location,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: RS.font(context, 16),
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.primaryTextDarkColor,
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
                    t.locationDescription,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: RS.font(context, 16),
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.primaryTextDarkColor,
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
              text: t.onboardingContinue,
              onPressed: () {
                if (orderVM.formKey.currentState?.validate() ?? false) {
                  _goToStep(OrderStep.priority);
                }
              },
            ),
          ),
        ],
      );
  }

  // ================= STEP 2: نوع الطلب =================
  Widget _buildPriorityStep(
    BuildContext context,
    AppLocalizations t,
    CreateOrderViewModel orderVM,
  ) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ServiceRequestPrioritySection(
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
            onPressed: () {
              if (selectedPriority == RequestPriority.scheduled) {
                _goToStep(OrderStep.booking);
              } else {
                _goToStep(OrderStep.confirmation);
              }
            },
          ),
        ),
      ],
    );
  }

  // ================= STEP 3: الحجز (التاريخ والوقت) =================
  Widget _buildBookingStep(
    BuildContext context,
    AppLocalizations t,
    CreateOrderViewModel orderVM,
  ) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: InlineDateTimePicker(
              selectedDateTime: orderVM.scheduledDate,
              onChanged: (dateTime) {
                setState(() {
                  orderVM.setScheduledDate(dateTime);
                });
              },
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
            onPressed: () {
              if (orderVM.scheduledDate == null) {
                showTemporaryMessage(
                  context,
                  t.scheduledDateRequired,
                  MessageType.error,
                );
                return;
              }
              _goToStep(OrderStep.confirmation);
            },
          ),
        ),
      ],
    );
  }

  // ================= STEP 4: التأكيد =================
  Widget _buildConfirmationStep(
    BuildContext context,
    AppLocalizations t,
    CreateOrderViewModel orderVM,
  ) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "تأكيد الطلب",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: RS.font(context, 20),
                    color: ColorsManager.primaryTextDarkColor,
                  ),
                ),

                // SizedBox(height: RS.size(context, 16)),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0.0,
                    vertical: 10,
                  ),
                  child: OrderSummaryDetailsCard(
                    title: widget.title,
                    location: orderVM.locationAreaController.text.trim(),
                    locationDetails: orderVM.locationDetailsController.text
                        .trim(),
                    description: orderVM.descriptionController.text.trim(),
                    priority: selectedPriority,
                    scheduledDate: orderVM.scheduledDate,
                    imagesCount: orderVM.uploadedImages.length,
                  ),
                ),

                SizedBox(height: RS.size(context, 16)),
                const OrderSummaryPricingCard(),

                SizedBox(height: RS.size(context, 50)),

                // const ServiceRequestVideoSection(),
                // SizedBox(height: RS.size(context, 24)),

                // VideoCallInfoSection(
                //   onRequestVideoCall: () {
                //     WhatsAppService.openChat(
                //       phone: '+962781319003',
                //       message: 'مرحبا اريد اجراء مكالمه فيديو  عاجله معك الان',
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
        // const Divider(),

        /// ================= SUBMIT (اللوجيك الأصلي زي ما هو) =================
        ServiceRequestSubmitSection(
          mainCategoryId: widget.mainCategoryId,
          categoryId: widget.categoryId,
          subserviceId: widget.subserviceId,
          title: widget.title,
          locationUrl: orderVM.locationUrlController.text.trim(),
          location: orderVM.locationAreaController.text.trim(),
          locationDetails: orderVM.locationDetailsController.text.trim(),
        ),

        /// ===== تعديل الطلب =====
        Padding(
          padding: EdgeInsets.symmetric(vertical: RS.size(context, 4)),
          child: TextButton(
            onPressed: () => _goToStep(OrderStep.edit),
            child: Text(
              "تعديل الطلب",
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

  bool _showDatePickerInline = false;

  // ================= STEP: تعديل الطلب =================
  Widget _buildEditStep(
    BuildContext context,
    AppLocalizations t,
    CreateOrderViewModel orderVM,
  ) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "تعديل الطلب",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: RS.font(context, 20),
                    color: ColorsManager.primaryTextDarkColor,
                  ),
                ),
                SizedBox(height: RS.size(context, 16)),

                /// ===== كارت الخدمة (Static مؤقتًا - مفيش صورة/تقييم/سعر حقيقي) =====
                Container(
                  padding: EdgeInsets.all(RS.size(context, 12)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(RS.radius(context, 12)),
                    border: Border.all(color: ColorsManager.grey),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.image_outlined,
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title ?? '',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: RS.font(context, 14),
                                  ),
                            ),
                            SizedBox(height: RS.size(context, 4)),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "4.5 (70 تقيم)", // Static
                                  style: TextStyle(
                                    fontSize: RS.font(context, 12),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: RS.size(context, 4)),
                            Text(
                              "200/ساعة", // Static
                              style: TextStyle(
                                color: ColorsManager.secondaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: RS.font(context, 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: RS.size(context, 16)),

                Text(
                  "تغيير الخدمة",
                  style: TextStyle(
                    color: ColorsManager.primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: RS.font(context, 13),
                  ),
                ),

                SizedBox(height: RS.size(context, 16)),

                /// ===== الموقع (حقيقي - عرض فقط) =====
                _sectionLabel(context, t.location),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(RS.size(context, 12)),
                  decoration: BoxDecoration(
                    color: ColorsManager.primaryColor.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(RS.radius(context, 10)),
                  ),
                  child: Text(
                    "${orderVM.locationAreaController.text.trim()}-${orderVM.locationDetailsController.text.trim()}",
                    style: TextStyle(fontSize: RS.font(context, 13)),
                  ),
                ),

                SizedBox(height: RS.size(context, 16)),

                /// ===== الموعد (حقيقي - قابل للتعديل) =====
                _sectionLabel(context, "الموعد"),
                GestureDetector(
                  onTap: () {
                    setState(
                      () => _showDatePickerInline = !_showDatePickerInline,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: RS.size(context, 12),
                      vertical: RS.size(context, 12),
                    ),
                    decoration: BoxDecoration(
                      color: ColorsManager.primaryColor.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(
                        RS.radius(context, 10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          orderVM.scheduledDate != null
                              ? "${orderVM.scheduledDate!.day} ${_monthArabic(orderVM.scheduledDate!.month)} ${orderVM.scheduledDate!.year} - ${TimeOfDay.fromDateTime(orderVM.scheduledDate!).format(context)}"
                              : t.chooseDate,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: RS.font(context, 13),
                          ),
                        ),
                        Icon(
                          _showDatePickerInline
                              ? Icons.keyboard_arrow_up
                              : Icons.chevron_right,
                          color: ColorsManager.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),

                if (_showDatePickerInline) ...[
                  SizedBox(height: RS.size(context, 12)),
                  InlineDateTimePicker(
                    selectedDateTime: orderVM.scheduledDate,
                    onChanged: (dateTime) {
                      setState(() {
                        orderVM.setScheduledDate(dateTime);
                      });
                    },
                  ),
                ],

                SizedBox(height: RS.size(context, 16)),

                /// ===== نوع الطلب (حقيقي) =====
                _sectionLabel(context, "نوع الطلب"),
                _priorityRadioTile(
                  context,
                  label: t.scheduled,
                  value: RequestPriority.scheduled,
                  orderVM: orderVM,
                ),
                _priorityRadioTile(
                  context,
                  label: t.urgent,
                  value: RequestPriority.urgent,
                  orderVM: orderVM,
                ),
                _priorityRadioTile(
                  context,
                  label: t.emergency,
                  value: RequestPriority.emergency,
                  orderVM: orderVM,
                ),

                SizedBox(height: RS.size(context, 16)),

                /// ===== وصف المشكلة (حقيقي) =====
                _sectionLabel(context, "وصف المشكله"),
                CustomTextFormField(
                  textEditingController: orderVM.descriptionController,
                  hintText: t.writeRequestDetailsHint,
                  maxLines: 4,
                  onChanged: (_) => setState(() {}), // لتحديث العداد فقط
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    "${orderVM.descriptionController.text.length}/500",
                    style: TextStyle(
                      fontSize: RS.font(context, 11),
                      color: ColorsManager.secondaryTextDarkColor,
                    ),
                  ),
                ),

                SizedBox(height: RS.size(context, 16)),

                /// ===== المرفقات (حقيقية) =====
                _sectionLabel(context, t.uploadedPhotos),
                const ServiceRequestImagesSection(),
              ],
            ),
          ),
        ),

        const Divider(),

        /// ===== حفظ التعديلات =====
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: RS.size(context, 16),
            vertical: RS.size(context, 10),
          ),
          child: CustomButton(
            text: "حفظ التعديلات",
            onPressed: () {
              _goToStep(OrderStep.confirmation);
            },
          ),
        ),
      ],
    );
  }

  Widget _sectionLabel(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: RS.size(context, 8)),
      child: Text(
        text,
        style: TextStyle(
          fontSize: RS.font(context, 14),
          fontWeight: FontWeight.w600,
          color: ColorsManager.primaryTextDarkColor,
        ),
      ),
    );
  }

  Widget _priorityRadioTile(
    BuildContext context, {
    required String label,
    required RequestPriority value,
    required CreateOrderViewModel orderVM,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedPriority = value;
          orderVM.selectedPriority = value;
          if (value != RequestPriority.scheduled) {
            orderVM.setScheduledDate(null);
          }
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: RS.size(context, 4)),
        child: Row(
          children: [
            Radio<RequestPriority>(
              value: value,
              groupValue: selectedPriority,
              activeColor: ColorsManager.primaryColor,
              onChanged: (v) {
                setState(() {
                  selectedPriority = v!;
                  orderVM.selectedPriority = v;
                  if (v != RequestPriority.scheduled) {
                    orderVM.setScheduledDate(null);
                  }
                });
              },
            ),
            Text(label, style: TextStyle(fontSize: RS.font(context, 13))),
          ],
        ),
      ),
    );
  }

  String _monthArabic(int month) {
    const months = [
      "يناير",
      "فبراير",
      "مارس",
      "أبريل",
      "مايو",
      "يونيو",
      "يوليو",
      "أغسطس",
      "سبتمبر",
      "أكتوبر",
      "نوفمبر",
      "ديسمبر",
    ];
    return months[month - 1];
  }
}
