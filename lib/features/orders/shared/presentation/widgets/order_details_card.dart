import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/core/di/di.dart';
import 'package:meayar_alitqan/features/orders/shared/presentation/widgets/cancel_order_section.dart';
import 'package:meayar_alitqan/features/orders/shared/presentation/widgets/order_update_status_button.dart';
import 'package:meayar_alitqan/features/orders/technician/presentation/views/order_details_view.dart';
import 'package:meayar_alitqan/features/reviews/presentation/manager/has_review_view_model/has_review_view_model.dart';
import 'package:meayar_alitqan/features/reviews/presentation/manager/has_review_view_model/has_review_view_model_states.dart';
import 'package:meayar_alitqan/features/reviews/presentation/widgets/show_review_bottom_sheet_content.dart';
import 'package:meayar_alitqan/features/spare_parts/presentation/manager/add_spare_part_view_model/add_spare_part_view_model.dart';
import 'package:meayar_alitqan/features/spare_parts/presentation/manager/get_spare_part_view_model/get_spare_part_view_model.dart';
import 'package:meayar_alitqan/features/spare_parts/presentation/widgets/order_spare_parts_section.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/enums/order_status.dart';
import '../../../../../core/enums/request_priority.dart';
import '../../../../../core/helper/responsive_size.dart';
import '../../../../../core/utils/colors_manager.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../customer/presentation/widgets/order_media_section.dart';
import '../../../customer/presentation/widgets/order_technician_section.dart';
import '../../domain/entities/order_entity/order_entity.dart';
import 'order_header.dart';

class OrderDetailsCard extends StatefulWidget {
  final String orderNumber;
  final String publicDetails;
  final Color statusColor;
  final IconData statusIcon;

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
    required this.statusIcon,
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
          borderRadius: BorderRadius.circular(RS.radius(context, 14)),
          border: Border.all(color: ColorsManager.grey, width: 1),
        ),
        padding: EdgeInsets.symmetric(vertical: RS.size(context, 14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OrderHeader(
              orderNumber: widget.orderNumber,
              title: widget.publicDetails,
              status: widget.order!.status,
              statusColor: widget.statusColor,
              statusIcon: widget.statusIcon,
            ),
            SizedBox(height: RS.size(context, 14)),

            if (_showLocation)
              Row(
                children: [
                  Expanded(
                    child: _iconTextRow(
                      context,
                      Icons.location_on_outlined,
                      widget.order!.location,
                    ),
                  ),
                  Expanded(
                    child: _iconTextRow(
                      context,
                      Icons.calendar_today_outlined,
                      widget.serviceDate,
                    ),
                  ),
                ],
              ),

            SizedBox(height: RS.size(context, 10)),

            if (_hasPrice) _priceRow(context),
             if (_hasPrice) SizedBox(height: RS.size(context, 14)),

            // if (_showMedia &&
            //     (widget.photos.isNotEmpty || widget.videos.isNotEmpty))
            //   Padding(
            //     padding: EdgeInsets.symmetric(horizontal: RS.size(context, 12)),
            //     child: OrderMediaSection(
            //       photos: widget.photos,
            //       videos: widget.videos,
            //     ),
            //   ),

            if (_hasTechnician)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: RS.size(context, 12)),
                child: _technicianSection(),
              ),
            if (_showNoTechnician)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: RS.size(context, 12)),
                child: _noTechnicianText(context),
              ),

            if (widget.isTechnician && _isSparePart) _showSpareParts(),

            SizedBox(height: RS.size(context, 4)),
            _actionsRow(context),
          ],
        ),
      ),
    );
  }

  Widget _iconTextRow(BuildContext context, IconData icon, String value) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: RS.size(context, 12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: RS.size(context, 15),
              color: ColorsManager.primaryColor,
            ),
            SizedBox(width: RS.size(context, 6)),

            Flexible(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: RS.font(context, 14),
                  fontWeight: FontWeight.w400,
                  color: ColorsManager.darkGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceRow(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: RS.size(context, 12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.expectedPrice,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: RS.font(context, 14),
                fontWeight: FontWeight.w400,
                color: ColorsManager.darkGrey,
              ),
            ),
            Text(
              widget.order!.price.toString(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: RS.font(context, 14),
                fontWeight: FontWeight.w500,
                color: ColorsManager.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionsRow(BuildContext context) {
    final buttons = <Widget>[];

    if (_showUpdateStatus) {
      buttons.add(
        Expanded(child: OrderDetailsUpdateStatusButton(order: widget.order!)),
      );
    } else if (_showViewDetails) {
      buttons.add(Expanded(child: _viewDetailsButton(context)));
    }
    buttons.add(Expanded(child: _viewDetailsButton(context)));

    if (_showCancel) {
      buttons.add(Expanded(child: CancelOrderSection(orderId: widget.orderId)));
    }

    if (buttons.isEmpty) return const SizedBox.shrink();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: RS.size(context, 12)),
        child: Row(
          children: [
            for (int i = 0; i < buttons.length; i++) ...[
              if (i != 0) SizedBox(width: RS.size(context, 10)),
              buttons[i],
            ],
          ],
        ),
      ),
    );
  }

  Widget _viewDetailsButton(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!mounted) return;
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (_) => OrderDetailsView(order: widget.order!),
          ),
        );
      },
      child: Container(
        height: RS.size(context, 44),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RS.radius(context, 10)),
          border: Border.all(color: ColorsManager.primaryColor, width: 1.5),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.viewDetails,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.primaryColor,
                  fontSize: RS.font(context, 14),
                ),
              ),
              SizedBox(width: RS.size(context, 4)),
              Icon(
                Icons.chevron_right,
                size: RS.size(context, 18),
                color: ColorsManager.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? get _authUserId => Supabase.instance.client.auth.currentUser?.id;

  String? get _fromUserId {
    final authId = _authUserId;
    if (authId == null) return null;
    return authId;
  }

  String get _fromRole =>
      _authUserId == widget.order?.technician?.id ? 'technician' : 'customer';

  String get _toRole => _fromRole == 'technician' ? 'customer' : 'technician';

  String? get _toUserId {
    final authId = _authUserId;
    if (authId == null) return null;
    if (authId == widget.order?.technician?.id)
      return widget.order?.customer?.id;
    if (authId == widget.order?.customer?.id)
      return widget.order?.technician?.id;
    return null;
  }

  Widget _showSpareParts() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: RS.size(context, 12),
        vertical: RS.size(context, 8),
      ),
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
                        getIt<GetSparePartViewModel>()
                          ..getSparePart(widget.orderId),
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
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ColorsManager.primaryColor,
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
    if (fromUserId == null || toUserId == null) return const SizedBox.shrink();

    return BlocBuilder<HasReviewViewModel, HasReviewViewModelStates>(
      builder: (context, state) {
        if (state is HasReviewLoading || state is HasReviewError) {
          return const SizedBox.shrink();
        }
        if (state is HasReviewSuccess) {
          final hasReview = state.hasReview;
          return OrderTechnicianSection(
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
                      builder: (_) => ShowReviewBottomSheetContent(
                        orderId: widget.orderId,
                        fromUserId: fromUserId,
                        toUserId: toUserId,
                        fromRole: _fromRole,
                        toRole: _toRole,
                      ),
                    );
                  },
            technicianName: widget.order?.technician?.name ?? '',
            technicianAvatar:
                widget.order?.technician?.avatarUrl ??
                widget.order?.technician?.name[0],
            rating: widget.order?.technician?.rating.toInt() ?? 0,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _noTechnicianText(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.noTechnicianAssigned,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: RS.font(context, 14),
      ),
    );
  }
}
