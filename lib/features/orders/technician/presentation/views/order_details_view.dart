import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/core/helper/web_max_width.dart';
import 'package:meayar_alitqan/features/orders/shared/presentation/manager/get_invoice_view_model/get_invoice_view_model.dart';
import 'package:meayar_alitqan/features/spare_parts/presentation/manager/get_spare_part_view_model/get_spare_part_view_model.dart';

import '../../../../../core/components/custom_app_bar.dart';
import '../../../../../core/di/di.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../customer/presentation/manager/cancel_order_view_model/cancel_order_view_model.dart';
import '../../../shared/domain/entities/order_entity/order_entity.dart';
import '../widgets/order_details_view_body.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key, required this.order});
  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
        final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(title: loc.requestDetails,centerTitle: true,),
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<CancelOrderViewModel>()),
            BlocProvider(
              create: (_) => getIt<GetSparePartViewModel>()..getSparePart(
                order.id
              ),
            ),
            BlocProvider(create: (context) => getIt<GetInvoiceViewModel>()..getInvoice(order.id)),
          ],
          child: WebMaxWidth(child: OrderDetailsViewBody(orderEntity: order)),
        ),
      ),
    );
  }
}
