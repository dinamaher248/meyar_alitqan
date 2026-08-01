import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/components/custom_button.dart';
import 'package:meayar_alitqan/core/components/custom_text_field.dart';
import 'package:meayar_alitqan/core/enums/request_priority.dart';
import 'package:meayar_alitqan/core/helper/responsive_size.dart';
import 'package:meayar_alitqan/core/utils/arabic_date_formatter.dart';
import 'package:meayar_alitqan/core/utils/colors_manager.dart';
import 'package:meayar_alitqan/features/orders/customer/presentation/manager/create_order_view_model/create_order_view_model.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/common/priority_radio_tile.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/common/section_label.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/inline_date_time_picker.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/service_request_images_section.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

/// Step: edit an already-filled request.
/// `_showDatePickerInline` is purely a UI toggle for this step, so it now
/// lives here instead of leaking into the parent's state.
class ServiceRequestEditStep extends StatefulWidget {
  const ServiceRequestEditStep({
    super.key,
    required this.title,
    required this.orderVM,
    required this.selectedPriority,
    required this.onPriorityChanged,
    required this.onSave,
  });

  final String? title;
  final CreateOrderViewModel orderVM;
  final RequestPriority selectedPriority;
  final ValueChanged<RequestPriority> onPriorityChanged;
  final VoidCallback onSave;

  @override
  State<ServiceRequestEditStep> createState() => _ServiceRequestEditStepState();
}

class _ServiceRequestEditStepState extends State<ServiceRequestEditStep> {
  bool _showDatePickerInline = false;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final orderVM = widget.orderVM;

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

                /// ===== كارت الخدمة (Static مؤقتًا) =====
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
                        child: const Icon(Icons.image_outlined, color: Colors.grey),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title ?? '',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: RS.font(context, 14),
                              ),
                            ),
                            SizedBox(height: RS.size(context, 4)),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 16),
                                const SizedBox(width: 4),
                                Text("4.5 (70 تقيم)", style: TextStyle(fontSize: RS.font(context, 12))),
                              ],
                            ),
                            SizedBox(height: RS.size(context, 4)),
                            Text(
                              "200/ساعة",
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

                /// ===== الموقع (عرض فقط) =====
                SectionLabel(t.location),
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

                /// ===== الموعد (قابل للتعديل) =====
                SectionLabel("الموعد"),
                GestureDetector(
                  onTap: () => setState(() => _showDatePickerInline = !_showDatePickerInline),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: RS.size(context, 12),
                      vertical: RS.size(context, 12),
                    ),
                    decoration: BoxDecoration(
                      color: ColorsManager.primaryColor.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(RS.radius(context, 10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          orderVM.scheduledDate != null
                              ? "${orderVM.scheduledDate!.day} ${ArabicDateFormatter.monthName(orderVM.scheduledDate!.month)} ${orderVM.scheduledDate!.year} - ${TimeOfDay.fromDateTime(orderVM.scheduledDate!).format(context)}"
                              : t.chooseDate,
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: RS.font(context, 13)),
                        ),
                        Icon(
                          _showDatePickerInline ? Icons.keyboard_arrow_up : Icons.chevron_right,
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
                    onChanged: (dateTime) => setState(() => orderVM.setScheduledDate(dateTime)),
                  ),
                ],

                SizedBox(height: RS.size(context, 16)),

                /// ===== نوع الطلب =====
                SectionLabel("نوع الطلب"),
                PriorityRadioTile(
                  label: t.scheduled,
                  value: RequestPriority.scheduled,
                  groupValue: widget.selectedPriority,
                  onChanged: widget.onPriorityChanged,
                ),
                PriorityRadioTile(
                  label: t.urgent,
                  value: RequestPriority.urgent,
                  groupValue: widget.selectedPriority,
                  onChanged: widget.onPriorityChanged,
                ),
                PriorityRadioTile(
                  label: t.emergency,
                  value: RequestPriority.emergency,
                  groupValue: widget.selectedPriority,
                  onChanged: widget.onPriorityChanged,
                ),

                SizedBox(height: RS.size(context, 16)),

                /// ===== وصف المشكلة =====
                SectionLabel("وصف المشكله"),
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
                    style: TextStyle(fontSize: RS.font(context, 11), color: ColorsManager.secondaryTextDarkColor),
                  ),
                ),

                SizedBox(height: RS.size(context, 16)),

                /// ===== المرفقات =====
                SectionLabel(t.uploadedPhotos),
                const ServiceRequestImagesSection(),
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
            text: "حفظ التعديلات",
            onPressed: widget.onSave,
          ),
        ),
      ],
    );
  }
}
