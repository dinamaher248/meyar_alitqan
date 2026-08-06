import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meayar_alitqan/features/orders/shared/domain/entities/order_entity/order_entity.dart';

import '../../../../../core/di/di.dart';
import '../../../../../core/helper/order_status_color.dart';
import '../../../../../core/helper/order_status_icon.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../technician/presentation/manager/update_order_status_view_model/update_order_status_view_model.dart';
import 'order_details_card.dart';

class OrderDetailsList extends StatelessWidget {
  const OrderDetailsList({
    super.key,
    required this.orders,
    this.isTechnician = false,
  });

  final List<OrderEntity> orders;
  final bool isTechnician;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

      itemBuilder: (context, index) {
        final localDate = orders[index].createdAt.toLocal();
        return BlocProvider(
          create: (context) => getIt<UpdateOrderStatusViewModel>(),
          child: OrderDetailsCard(
            orderId: orders[index].id,
            technicianId: orders[index].technicianId ?? "",
            photos: orders[index].images,
            videos: orders[index].videos,
            orderNumber: (index + 1).toString(),
            publicDetails: orders[index].title ?? "", //  AppLocalizations.of(context)!.publicDetails
            statusColor: OrderStatusColor.fromStatus(orders[index].status),
            statusIcon: OrderStatusExtension.icon(orders[index].status),
            serviceName: orders[index].title ?? "",
            serviceDate: DateFormat('dd/MM/yyyy').format(localDate),
            serviceType: orders[index].level,
            order: orders[index],
            isTechnician: isTechnician,
          ),
        );
      },
    );
  }
}
