// import 'package:flutter/widgets.dart';
// import 'package:meayar_alitqan/config/routes/routes_manager.dart';
// import 'package:meayar_alitqan/core/components/custom_button.dart';
// import 'package:meayar_alitqan/features/orders/shared/domain/entities/order_entity/order_entity.dart';
// import 'package:meayar_alitqan/features/orders/shared/presentation/widgets/order_call_button.dart';
// import 'package:meayar_alitqan/features/orders/shared/presentation/widgets/order_cancel_section.dart';
// import 'package:meayar_alitqan/features/orders/shared/presentation/widgets/order_details_conditions.dart';
// import 'package:meayar_alitqan/features/orders/shared/presentation/widgets/order_update_status_button.dart';
// import 'package:meayar_alitqan/l10n/app_localizations.dart';

// class OrderDetailsActionsSection extends StatelessWidget {
//   const OrderDetailsActionsSection({
//     super.key,
//     required this.order,
//     required this.conditions,
//   });

//   final OrderEntity order;
//   final OrderDetailsConditions conditions;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         if (conditions.showViewDetails)
//           CustomButton(
//             text: AppLocalizations.of(context)!.viewDetails,
//             onPressed: () {
//               Navigator.pushNamed(
//                 context,
//                 RoutesManager.orderDetailsView,
//                 arguments: order,
//               );
//             },
//           ),

//         if (conditions.showUpdateStatus)
//           OrderUpdateStatusButton(order: order),

//         if (conditions.showCancel)
//           OrderCancelSection(orderId: order.id),

//         if (conditions.showCall)
//           OrderCallButton(phone: order.customer!.phone!),
//       ],
//     );
//   }
// }
