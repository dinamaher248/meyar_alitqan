import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meayar_alitqan/core/utils/colors_manager.dart';
import 'package:meayar_alitqan/features/orders/shared/domain/entities/invoice_entity/invoice_entity.dart';
import 'package:meayar_alitqan/features/orders/shared/domain/entities/order_entity/order_entity.dart';
import 'package:meayar_alitqan/features/orders/shared/presentation/manager/get_invoice_view_model/get_invoice_view_model.dart';
import 'package:meayar_alitqan/features/orders/shared/presentation/manager/get_invoice_view_model/get_invoice_view_model_states.dart';
import 'package:meayar_alitqan/features/spare_parts/presentation/manager/get_spare_part_view_model/get_spare_part_view_model.dart';
import 'package:meayar_alitqan/features/spare_parts/presentation/manager/get_spare_part_view_model/get_spare_part_view_model_states.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/enums/order_status.dart';
import '../../../../../core/extensions/order_status.dart';
import '../../../../../core/helper/responsive_size.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../customer/presentation/manager/cancel_order_view_model/cancel_order_view_model.dart';
import '../../../customer/presentation/manager/cancel_order_view_model/cancel_order_view_model_states.dart';
import '../../../technician/presentation/manager/update_order_status_view_model/update_order_status_view_model.dart';
import '../../../technician/presentation/manager/update_order_status_view_model/update_order_status_view_model_states.dart';

class OrderDetailsViewBody extends StatefulWidget {
  const OrderDetailsViewBody({
    super.key,
    required this.orderEntity,
    this.isTechnician = false, // ✅ جديد
  });

  final OrderEntity orderEntity;
  final bool isTechnician;

  @override
  State<OrderDetailsViewBody> createState() => _OrderDetailsViewBodyState();
}

class _OrderDetailsViewBodyState extends State<OrderDetailsViewBody> {
  late final TextEditingController _detailsController;
  late final TextEditingController _locationController;
  late final TextEditingController _scheduleDateController;

  InvoiceEntity? _invoice;

  BuildContext? _dialogContext;
  bool _dialogOpened = false;

  @override
  void initState() {
    super.initState();

    _detailsController = TextEditingController(
      text: widget.orderEntity.description,
    );
    _locationController = TextEditingController(
      text: widget.orderEntity.location,
    );
    _scheduleDateController = TextEditingController(
      text: DateFormat(
        'yyyy-MM-dd',
      ).format(widget.orderEntity.scheduledDate ?? DateTime.now()),
    );
  }

  @override
  void dispose() {
    _detailsController.dispose();
    _locationController.dispose();
    _scheduleDateController.dispose();
    super.dispose();
  }

  void _closeDialogIfOpen() {
    if (_dialogOpened &&
        _dialogContext != null &&
        Navigator.of(_dialogContext!).canPop()) {
      Navigator.of(_dialogContext!).pop();
      _dialogOpened = false;
      _dialogContext = null;
    }
  }

  (Color, IconData) _statusVisual(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return (Colors.orange, Icons.access_time_rounded);
      case OrderStatus.canceled:
        return (Colors.red, Icons.cancel_outlined);
      case OrderStatus.completed:
        return (Colors.green, Icons.check_circle_outline);
      default:
        return (Colors.blue, Icons.build_outlined);
    }
  }

  /// ===== يظهر Snackbar تأكيد مطابق لتصميم الصورة 2 =====
  void _showStatusUpdatedFeedback(
    BuildContext context,
    String message,
    String subMessage,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFDFF5E1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.green, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subMessage,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final order = widget.orderEntity;
    final (statusColor, statusIcon) = _statusVisual(order.status);

    return MultiBlocListener(
      listeners: [
        BlocListener<GetInvoiceViewModel, GetInvoiceViewModelStates>(
          listener: (context, state) {
            if (state is GetInvoiceViewModelLoading) {
              if (_dialogOpened) return;
              _dialogOpened = true;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (dialogCtx) {
                  _dialogContext = dialogCtx;
                  return const Center(child: CircularProgressIndicator());
                },
              );
            }
            if (state is GetInvoiceViewModelError) {
              _closeDialogIfOpen();
              if (state.failure.message == "Invoice not found") {
                _invoice = null;
                return;
              }
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.failure.message)));
            }
            if (state is GetInvoiceViewModelSuccess) {
              _closeDialogIfOpen();
              setState(() => _invoice = state.invoice);
            }
          },
        ),

        /// ===== قبول / تحديث الحالة =====
        BlocListener<
          UpdateOrderStatusViewModel,
          UpdateOrderStatusViewModelStates
        >(
          listener: (context, state) {
            if (state is UpdateOrderStatusViewModelSuccess) {
              _showStatusUpdatedFeedback(
                context,
                'تم تحديث حاله الخدمه',
                'يمكنك الان البدء في التنفيذ',
              );
              Navigator.pop(context); // يرجّع للـ List عشان يتحدّث تلقائيًا
            }
            if (state is UpdateOrderStatusViewModelError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),

        /// ===== رفض / إلغاء =====
        BlocListener<CancelOrderViewModel, CancelOrderViewModelStates>(
          listener: (context, state) {
            if (state is CancelOrderViewModelSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(t.orderCancelledSuccessfully),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            }
            if (state is CancelOrderViewModelError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ],
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: RS.size(context, 12),
                vertical: RS.size(context, 12),
              ),
              child: Directionality(
                textDirection: ui.TextDirection.rtl,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: RS.size(context, 16),
                    vertical: RS.size(context, 18),
                  ),
                  decoration: BoxDecoration(
                    color: ColorsManager.white,
                    borderRadius: BorderRadius.circular(RS.radius(context, 14)),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _headerRow(context, order, statusColor, statusIcon),
                      SizedBox(height: RS.size(context, 18)),

                      _valueRow(
                        context,
                        Icons.category_outlined,
                        _safe(() => order.categoryId, t.serviceName),
                      ),
                      SizedBox(height: RS.size(context, 12)),

                      _valueRow(
                        context,
                        Icons.calendar_today_outlined,
                        _scheduleDateController.text,
                      ),
                      SizedBox(height: RS.size(context, 12)),

                      _valueRow(
                        context,
                        Icons.location_on_outlined,
                        _locationController.text,
                      ),
                      SizedBox(height: RS.size(context, 18)),

                      _sectionLabel(
                        context,
                        Icons.article_outlined,
                        t.problemDetails,
                      ),
                      SizedBox(height: RS.size(context, 8)),
                      _noteBox(context, _detailsController.text),
                      SizedBox(height: RS.size(context, 18)),

                      _sectionLabel(
                        context,
                        Icons.image_outlined,
                        t.uploadedPhotos,
                      ),
                      SizedBox(height: RS.size(context, 8)),
                      _mediaSummaryBox(context, order.images, order.videos),
                      SizedBox(height: RS.size(context, 18)),

                      BlocBuilder<
                        GetSparePartViewModel,
                        GetSparePartViewModelStates
                      >(
                        builder: (context, state) {
                          if (state is GetSparePartViewModelLoading) {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                          if (state is GetSparePartViewModelSuccess &&
                              state.spareParts.isNotEmpty) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _sectionLabel(
                                  context,
                                  Icons.settings_outlined,
                                  t.spareParts,
                                ),
                                SizedBox(height: RS.size(context, 8)),
                                ...state.spareParts.map(
                                  (part) => Container(
                                    decoration: BoxDecoration(
                                      color: ColorsManager.secondaryColor
                                          .withValues(alpha: 0.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    margin: const EdgeInsets.only(bottom: 8),
                                    child: ListTile(
                                      title: Text(
                                        part.partName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              fontSize: RS.font(context, 14),
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: RS.size(context, 10)),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),

                      _sectionLabel(
                        context,
                        Icons.timeline_outlined,
                        t.orderStatus,
                      ),
                      SizedBox(height: RS.size(context, 12)),
                      _StatusTimeline(currentStatus: order.status),
                      SizedBox(height: RS.size(context, 22)),

                      /// ===== بيانات العميل (بس للفني) =====
                      if (widget.isTechnician) ...[
                        _sectionLabel(
                          context,
                          Icons.person_outline,
                          "بيانات العميل",
                        ),
                        SizedBox(height: RS.size(context, 10)),
                        _customerInfoRow(context, order),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// ===== الأزرار السفلية =====
          if (widget.isTechnician) _bottomActionButtons(context, order),
        ],
      ),
    );
  }

  // ---------------- بيانات العميل ----------------

  Widget _customerInfoRow(BuildContext context, OrderEntity order) {
    final customer = order.customer;

    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Row(
        children: [
          if (customer?.phone != null && customer!.phone!.isNotEmpty)
            InkWell(
              onTap: () async {
                final uri = Uri(scheme: 'tel', path: customer.phone);
                if (await canLaunchUrl(uri)) await launchUrl(uri);
              },
              child: Container(
                padding: EdgeInsets.all(RS.size(context, 10)),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.phone_outlined,
                  color: Colors.blue,
                  size: RS.size(context, 18),
                ),
              ),
            ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                customer?.name ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: RS.font(context, 13),
                ),
              ),
              if (customer?.phone != null)
                Text(
                  customer!.phone!,
                  style: TextStyle(
                    fontSize: RS.font(context, 11),
                    color: Colors.grey.shade600,
                  ),
                ),
            ],
          ),
          SizedBox(width: RS.size(context, 8)),
          CircleAvatar(
            radius: RS.size(context, 18),
            backgroundColor: Colors.grey.shade200,
            backgroundImage:
                (customer?.avatarUrl != null && customer!.avatarUrl.isNotEmpty)
                ? NetworkImage(customer.avatarUrl)
                : null,
            child: (customer?.avatarUrl == null || customer!.avatarUrl.isEmpty)
                ? const Icon(Icons.person, color: Colors.grey)
                : null,
          ),
        ],
      ),
    );
  }

  // ---------------- الأزرار السفلية ----------------

  Widget _bottomActionButtons(BuildContext context, OrderEntity order) {
    final t = AppLocalizations.of(context)!;

    /// ===== طلب pending: قبول / رفض =====
    if (order.status == OrderStatus.pending) {
      return Padding(
        padding: EdgeInsets.all(RS.size(context, 12)),
        child: Row(
          children: [
            Expanded(child: _updateStatusButton(context, order, label: "قبول")),
            SizedBox(width: RS.size(context, 10)),

            Expanded(child: _rejectButton(context, order)),
          ],
        ),
      );
    }

    /// ===== inProgress: إنهاء التنفيذ بس =====
    if (order.status == OrderStatus.inProgress) {
      return Padding(
        padding: EdgeInsets.all(RS.size(context, 12)),
        child: _updateStatusButton(
          context,
          order,
          label: "إنهاء التنفيذ",
          fullWidth: true,
        ),
      );
    }

    /// ===== assigned / onTheWay / arrived: إلغاء + تحديث =====
    if (order.status == OrderStatus.assigned ||
        order.status == OrderStatus.onTheWay ||
        order.status == OrderStatus.arrived) {
      return Padding(
        padding: EdgeInsets.all(RS.size(context, 12)),
        child: Row(
          children: [
            Expanded(child: _updateStatusButton(context, order)),
            SizedBox(width: RS.size(context, 10)),

            Expanded(child: _rejectButton(context, order, isCancel: true)),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _updateStatusButton(
    BuildContext context,
    OrderEntity order, {
    String? label,
    bool fullWidth = false,
  }) {
    final t = AppLocalizations.of(context)!;

    return BlocBuilder<
      UpdateOrderStatusViewModel,
      UpdateOrderStatusViewModelStates
    >(
      builder: (context, state) {
        final isLoading = state is UpdateOrderStatusViewModelLoading;
        final nextStatus = order.status.nextStatus();

        return SizedBox(
          width: fullWidth ? double.infinity : null,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(vertical: RS.size(context, 14)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(RS.radius(context, 10)),
              ),
            ),
            onPressed: isLoading || nextStatus == null
                ? null
                : () {
                    context
                        .read<UpdateOrderStatusViewModel>()
                        .updateOrderStatus(
                          orderId: order.id,
                          status: nextStatus.toApi(),
                        );
                  },
            child: isLoading
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    label ?? nextStatus?.localized(context) ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: RS.font(context, 14),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _rejectButton(
    BuildContext context,
    OrderEntity order, {
    bool isCancel = false,
  }) {
    final t = AppLocalizations.of(context)!;

    return BlocBuilder<CancelOrderViewModel, CancelOrderViewModelStates>(
      builder: (context, state) {
        final isLoading = state is CancelOrderViewModelLoading;

        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.red),
            padding: EdgeInsets.symmetric(vertical: RS.size(context, 14)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(RS.radius(context, 10)),
            ),
          ),
          onPressed: isLoading
              ? null
              : () {
                  context.read<CancelOrderViewModel>().cancelOrder(order.id);
                },
          child: isLoading
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(
                  isCancel ? "الغاء المهمة" : "رفض",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: RS.font(context, 14),
                  ),
                ),
        );
      },
    );
  }

  // ---------------- باقي الـ Helpers (زي ما هي من غير أي تغيير) ----------------

  String _safe(String? Function() getter, String fallback) {
    try {
      final v = getter();
      return (v == null || v.isEmpty) ? fallback : v;
    } catch (_) {
      return fallback;
    }
  }

  Widget _headerRow(
    BuildContext context,
    OrderEntity order,
    Color statusColor,
    IconData statusIcon,
  ) {
    final t = AppLocalizations.of(context)!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _safe(() => order.categoryId, t.serviceName),
                textAlign: TextAlign.right,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: RS.font(context, 16),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: RS.size(context, 4)),
              Text(
                '#${order.id.substring(0, 6)}',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: RS.font(context, 12),
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: RS.size(context, 8)),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: RS.size(context, 10),
            vertical: RS.size(context, 6),
          ),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(RS.radius(context, 20)),
            border: Border.all(color: statusColor.withValues(alpha: 0.5)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(statusIcon, size: RS.size(context, 14), color: statusColor),
              SizedBox(width: RS.size(context, 4)),
              Text(
                order.status.localized(context),
                style: TextStyle(
                  fontSize: RS.font(context, 11),
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _valueRow(BuildContext context, IconData icon, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, size: RS.size(context, 16), color: Colors.grey.shade600),
        SizedBox(width: RS.size(context, 6)),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: RS.font(context, 13),
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionLabel(BuildContext context, IconData icon, String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, size: RS.size(context, 16), color: Colors.grey.shade700),
        SizedBox(width: RS.size(context, 6)),
        Text(
          label,
          style: TextStyle(
            fontSize: RS.font(context, 14),
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _noteBox(BuildContext context, String text) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: RS.size(context, 12),
        vertical: RS.size(context, 12),
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(RS.radius(context, 10)),
      ),
      child: Text(
        text,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: RS.font(context, 13), color: Colors.black87),
      ),
    );
  }

  Widget _mediaSummaryBox(
    BuildContext context,
    List<String> images,
    List<String> videos,
  ) {
    final thumbs = images.take(3).toList();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: RS.size(context, 10),
        vertical: RS.size(context, 10),
      ),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(RS.radius(context, 10)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'تم رفع ${images.length} صور و ${videos.length} فيديو',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: RS.font(context, 13),
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ),
          SizedBox(width: RS.size(context, 8)),
          Row(
            children: thumbs
                .map(
                  (url) => Padding(
                    padding: EdgeInsets.only(left: RS.size(context, 6)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        RS.radius(context, 8),
                      ),
                      child: Image.network(
                        url,
                        width: RS.size(context, 44),
                        height: RS.size(context, 44),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

/// ===== نفس الـ StatusTimeline من غير أي تغيير =====
class _StatusTimeline extends StatelessWidget {
  final OrderStatus currentStatus;
  const _StatusTimeline({required this.currentStatus});

  @override
  Widget build(BuildContext context) {
    final steps = OrderStatus.values
        .where((s) => s != OrderStatus.canceled)
        .toList();
    final currentIndex = steps
        .indexOf(currentStatus)
        .clamp(0, steps.length - 1);

    return Row(
      children: [
        for (int i = 0; i < steps.length; i++) ...[
          if (i != 0) _connector(isDone: i <= currentIndex),
          _StepCircle(
            label: steps[i].localized(context),
            state: i < currentIndex
                ? _StepState.done
                : i == currentIndex
                ? _StepState.current
                : _StepState.pending,
          ),
        ],
      ],
    );
  }

  Widget _connector({required bool isDone}) {
    return Expanded(
      child: Container(
        height: 2,
        color: isDone ? Colors.green : Colors.grey.shade300,
      ),
    );
  }
}

enum _StepState { done, current, pending }

class _StepCircle extends StatelessWidget {
  final String label;
  final _StepState state;
  const _StepCircle({required this.label, required this.state});

  @override
  Widget build(BuildContext context) {
    final circle = switch (state) {
      _StepState.done => Container(
        width: RS.size(context, 24),
        height: RS.size(context, 24),
        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, size: 14, color: Colors.white),
      ),
      _StepState.current => Container(
        width: RS.size(context, 24),
        height: RS.size(context, 24),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.green, width: 2.5),
        ),
      ),
      _StepState.pending => Container(
        width: RS.size(context, 22),
        height: RS.size(context, 22),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          shape: BoxShape.circle,
        ),
      ),
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        circle,
        SizedBox(height: RS.size(context, 6)),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: RS.font(context, 10),
            fontWeight: state == _StepState.pending
                ? FontWeight.normal
                : FontWeight.bold,
            color: state == _StepState.pending
                ? Colors.grey.shade500
                : Colors.black87,
          ),
        ),
      ],
    );
  }
}
