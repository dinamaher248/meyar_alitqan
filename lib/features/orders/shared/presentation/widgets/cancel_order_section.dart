import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/core/components/app_loader.dart';
import 'package:meayar_alitqan/core/components/confirmation_dialog.dart';
import 'package:meayar_alitqan/features/orders/customer/presentation/manager/cancel_order_view_model/cancel_order_view_model.dart';
import 'package:meayar_alitqan/features/orders/customer/presentation/manager/cancel_order_view_model/cancel_order_view_model_states.dart';
import 'package:meayar_alitqan/features/orders/shared/presentation/widgets/cancel_order_button.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

import '../../../../../core/helper/responsive_size.dart';

class CancelOrderSection extends StatelessWidget {
  const CancelOrderSection({super.key, required this.orderId});
  final String orderId  ;

  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: BlocListener<CancelOrderViewModel, CancelOrderViewModelStates>(
        listener: (context, state) {
          if (state is CancelOrderViewModelSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  AppLocalizations.of(context)!.orderCancelledSuccessfully,
                   style:    TextStyle(color: Colors.white,fontSize:  RS.font(context, 16) ),
                ),
                backgroundColor: Colors.green,
              ),
            );
          }

          if (state is CancelOrderViewModelError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message,
                   style:    TextStyle(color: Colors.white,fontSize:  RS.font(context, 16) ),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<CancelOrderViewModel, CancelOrderViewModelStates>(
          builder: (context, state) {
            if (state is CancelOrderViewModelLoading) {
              return const SizedBox(height: 50, child: AppLoader());
            }

            return CancelOrderButton(
              onTap: () {
                showConfirmationDialog(
                  context: context,
                  title: AppLocalizations.of(context)!.cancelOrder,
                  message: AppLocalizations.of(
                    context,
                  )!.areYouSureYouWantToCancelThisOrder,
                  confirmText: AppLocalizations.of(context)!.yes,
                  cancelText: AppLocalizations.of(context)!.no,
                  onConfirm: () {
                    context.read<CancelOrderViewModel>().cancelOrder(
                      orderId,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}