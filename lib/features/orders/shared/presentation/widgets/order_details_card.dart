import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/config/routes/routes_manager.dart';
import 'package:meayar_alitqan/core/di/di.dart';
import 'package:meayar_alitqan/features/orders/shared/presentation/widgets/cancel_order_section.dart';
import 'package:meayar_alitqan/features/orders/shared/presentation/widgets/order_call_button.dart';
import 'package:meayar_alitqan/features/orders/shared/presentation/widgets/order_update_status_button.dart';
import 'package:meayar_alitqan/features/orders/technician/presentation/views/order_details_view.dart';
import 'package:meayar_alitqan/features/reviews/presentation/manager/has_review_view_model/has_review_view_model.dart';
import 'package:meayar_alitqan/features/reviews/presentation/manager/has_review_view_model/has_review_view_model_states.dart';
import 'package:meayar_alitqan/features/reviews/presentation/widgets/show_review_bottom_sheet_content.dart';
import 'package:meayar_alitqan/features/spare_parts/presentation/manager/add_spare_part_view_model/add_spare_part_view_model.dart';
import 'package:meayar_alitqan/features/spare_parts/presentation/manager/get_spare_part_view_model/get_spare_part_view_model.dart';
import 'package:meayar_alitqan/features/spare_parts/presentation/widgets/order_spare_parts_section.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/components/custom_button.dart';
import '../../../../../core/enums/order_status.dart';
import '../../../../../core/enums/request_priority.dart';
import '../../../../../core/helper/responsive_size.dart';
import '../../../../../core/utils/colors_manager.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../domain/entities/order_entity/order_entity.dart';
import '../../../customer/presentation/widgets/divider_section.dart';
import '../../../customer/presentation/widgets/expand_arrow.dart';
import 'order_header.dart';
import '../../../customer/presentation/widgets/order_media_section.dart';
import 'order_meta_section.dart';
import '../../../customer/presentation/widgets/order_technician_section.dart';

class OrderDetailsCard extends StatefulWidget {
  final String orderNumber;
  final String publicDetails;
  final Color statusColor;

  final String serviceName;
  final String serviceDate;
  final RequestPriority serviceType;

  final List<String> photos;
  final List<String> videos;
  final String technicianId;
  final String orderId;
  final bool isTechnician;
  final OrderEntity? order;

  const OrderDetailsCard({
    super.key,
    required this.orderNumber,
    required this.publicDetails,
    required this.statusColor,
    required this.serviceName,
    required this.serviceDate,
    required this.serviceType,
    required this.photos,
    required this.videos,
    required this.technicianId,
    required this.orderId,
    this.isTechnician = false,
    this.order,
  });

  @override
  State<OrderDetailsCard> createState() => _OrderDetailsCardState();
}

class _OrderDetailsCardState extends State<OrderDetailsCard> {
  bool isExpanded = false;

  bool get _isSparePart =>
      widget.order?.status != OrderStatus.completed &&
      widget.order?.status != OrderStatus.canceled;

  bool get _showMedia => !widget.isTechnician;

  bool get _showCancel =>
      !widget.isTechnician && widget.order!.status == OrderStatus.pending;

  bool get _showCallButton =>
      widget.isTechnician &&
      (widget.order?.customer?.phone?.isNotEmpty ?? false);

  bool get _showViewDetails => widget.isTechnician;

  bool get _hasTechnician =>
      widget.order?.technician != null && !widget.isTechnician;

  bool get _showNoTechnician =>
      widget.order?.technician == null && !widget.isTechnician;

  bool get _hasPrice =>
      widget.order?.price != null && (widget.order!.price ?? 0) > 0;

  bool get _showLocation =>
      widget.order?.location != null && widget.order!.location.isNotEmpty;

  bool get _showUpdateStatus => widget.isTechnician;
  late final HasReviewViewModel _hasReviewVM;

  @override
  void initState() {
    super.initState();
    _hasReviewVM = context.read<HasReviewViewModel>();
    _hasReviewVM.hasReview(orderId: widget.orderId);
  }

  // ================= BUILD =================
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: RS.size(context, 12),
        vertical: RS.size(context, 8),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(RS.radius(context, 10)),
          border: Border.all(
            color: ColorsManager.grey,
            width: RS.size(context, 2),
          ),
        ),
        child: Column(
          children: [
            OrderHeader(
              orderNumber: widget.orderNumber,
              title: widget.publicDetails,
              status: widget.order!.status,
              statusColor: widget.statusColor,
            ),
            SizedBox(height: RS.size(context, 16)),
            OrderMetaSection(
              serviceName: widget.serviceName,
              serviceDate: widget.serviceDate,
              serviceType: widget.serviceType,
              isTechnician: widget.isTechnician,
            ),
            SizedBox(height: RS.size(context, 12)),
            _expandArrow(),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isExpanded
                  ? _expandedContent(context)
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _expandArrow() {
    return ExpandArrow(
      isExpanded: isExpanded,
      onTap: () => setState(() => isExpanded = !isExpanded),
    );
  }

  Widget _expandedContent(BuildContext context) {
    return Column(
      children: [
        if (_hasPrice) ...[const DividerSection(), _priceRow(context)],

        SizedBox(height: RS.size(context, 12)),
        if (_showLocation) ...[const DividerSection(), _locationRow(context)],

        if (_showMedia && widget.photos.isNotEmpty ||
            widget.videos.isNotEmpty) ...[
          const DividerSection(),
          OrderMediaSection(photos: widget.photos, videos: widget.videos),
        ],
        if (_hasTechnician) ...[const DividerSection(), _technicianSection()],
        if (_showNoTechnician) ...[
          const DividerSection(),
          _noTechnicianText(context),
        ],

        const DividerSection(),
        if (_showViewDetails) _viewDetailsButton(),

        if (_showUpdateStatus)
          OrderDetailsUpdateStatusButton(order: widget.order!),

        if (widget.isTechnician && _isSparePart) _showSpareParts(),
        if (_showCancel) CancelOrderSection(orderId: widget.orderId),

        // if (_showCallButton)
        //   OrderDetailsCallButton(phone: widget.order!.customer!.phone!),
        SizedBox(height: RS.size(context, 16)),
      ],
    );
  }


  Widget _priceRow(BuildContext context)

  {

    return _infoRow(

      context,

      "${AppLocalizations.of(context)!.totalPrice} :",

      widget.order!.price.toString(),

    );

  }

  Widget _locationRow(BuildContext context)

  {

    return _infoRow(

      context,

      "${AppLocalizations.of(context)!.location} :",

      widget.order!.location,

    );

  }

  Widget _infoRow(BuildContext context, String label, String value)

  {

    return Padding(

      padding: const EdgeInsets.symmetric(horizontal: 8),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _labelText(context, label),

          SizedBox(width: RS.size(context, 8)),

          Expanded(child: _valueText(context, value)),
        ],
      ),
    );
  }

  Widget _labelText(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontSize: RS.font(context, 12),
        fontWeight: FontWeight.bold,
        color: ColorsManager.black,
      ),
    );
  }

  Widget _valueText(BuildContext context, String text) {
    return AutoSizeText(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      maxFontSize: RS.font(context, 12),
      minFontSize: RS.font(context, 8),
      stepGranularity: 1,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: ColorsManager.primaryColor,
      ),
    );
  }

  String? get _authUserId {
    return Supabase.instance.client.auth.currentUser?.id;
  }

  String? get _fromUserId {
    final authId = _authUserId;
    if (authId == null) return null;
    return authId;
  }

  String get _fromRole {
    return _authUserId == widget.order?.technician?.id
        ? 'technician'
        : 'customer';
  }

  String get _toRole {
    return _fromRole == 'technician' ? 'customer' : 'technician';
  }

  String? get _toUserId {
    final authId = _authUserId;
    if (authId == null) return null;

    if (authId == widget.order?.technician?.id) {
      return widget.order?.customer?.id;
    }

    if (authId == widget.order?.customer?.id) {
      return widget.order?.technician?.id;
    }

    return null;
  }

  Widget _showSpareParts() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (_) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => getIt<AddSparePartViewModel>()),
                  BlocProvider(
                    create: (_) =>
                        getIt<GetSparePartViewModel>()..getSparePart(
                          widget.orderId
                        ),
                  ),
                ],
                child: AddSparePartBottomSheet(
                  orderId: widget.orderId,
                  technicianId: widget.technicianId,
                ),
              );
            },
          );
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth:  RS.size(context, 420),
          ),
          child: Container(
            height: RS.size(context, 40),

            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorsManager.grey,
              border: Border.all(color: ColorsManager.primaryColor, width: 2),
              borderRadius: BorderRadius.circular(RS.radius(context, 10)),
            ),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.addSparePart,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize:  16,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.primaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _technicianSection() {
    final fromUserId = _fromUserId;
    final toUserId = _toUserId;

    if (fromUserId == null || toUserId == null) {
      return const SizedBox.shrink();
    }

    return BlocBuilder<HasReviewViewModel, HasReviewViewModelStates>(
      builder: (context, state) {
        if (state is HasReviewLoading) {
          return const SizedBox.shrink();
        }

        if (state is HasReviewError) {
          return const SizedBox.shrink();
        }

        if (state is HasReviewSuccess) {
          final hasReview = state.hasReview;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: OrderTechnicianSection(
              onTap: hasReview
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            AppLocalizations.of(context)!.alreadyReviewed,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: RS.font(context, 12),
                                  color: ColorsManager.white,
                                ),
                          ),
                        ),
                      );
                    }
                  : () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        builder: (_) {
                          return ShowReviewBottomSheetContent(
                            orderId: widget.orderId,
                            fromUserId: fromUserId,
                            toUserId: toUserId,
                            fromRole: _fromRole,
                            toRole: _toRole,
                          );
                        },
                      );
                    },
              technicianName: widget.order?.technician?.name ?? '',
              technicianAvatar:
                  widget.order?.technician?.avatarUrl ??
                  widget.order?.technician?.name[0],
              rating: widget.order?.technician?.rating.toInt() ?? 0,
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _noTechnicianText(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!

          .noTechnicianAssigned,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: RS.font(context, 14),
      ),
    );
  }

  Widget _viewDetailsButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CustomButton(
        height: RS.size(context, 40),
        text: AppLocalizations.of(context)!.viewDetails,
        onPressed: () {
          if (!mounted) return;

          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (_) => OrderDetailsView(order: widget.order!),
            ),
          );
        },
      ),
    );
  }

}
