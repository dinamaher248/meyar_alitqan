import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/core/components/app_loader.dart';
import 'package:meayar_alitqan/core/components/confirmation_dialog.dart';
import 'package:meayar_alitqan/features/orders/shared/presentation/widgets/cancel_order_button.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';
import '../../../customer/presentation/manager/cancel_order_view_model/cancel_order_view_model.dart';
import '../../../customer/presentation/manager/cancel_order_view_model/cancel_order_view_model_states.dart';
import '../../domain/entities/order_entity/order_entity.dart';

class OrderDetailsCancelSection extends StatelessWidget {
  final String orderId;
  final OrderEntity? order;

  const OrderDetailsCancelSection({
    super.key,
    required this.orderId,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: BlocListener<CancelOrderViewModel, CancelOrderViewModelStates>(
        listener: _onStateChanged,
        child: BlocBuilder<CancelOrderViewModel, CancelOrderViewModelStates>(
          builder: (context, state) {
            if (state is CancelOrderViewModelLoading) {
              return const SizedBox(height: 50, child: AppLoader());
            }

            return CancelOrderButton(
              onTap: () => _showCancelConfirmation(context),
            );
          },
        ),
      ),
    );
  }

  void _onStateChanged(BuildContext context, CancelOrderViewModelStates state) {
    final l10n = AppLocalizations.of(context)!;
    
    if (state is CancelOrderViewModelSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.orderCancelledSuccessfully),
          backgroundColor: Colors.green,
        ),
      );
    }

    if (state is CancelOrderViewModelError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showCancelConfirmation(BuildContext context) {
    showConfirmationDialog(
      context: context,
      title: AppLocalizations.of(context)!.cancelOrder,
      message: AppLocalizations.of(context)!.areYouSureYouWantToCancelThisOrder,
      confirmText: AppLocalizations.of(context)!.yes,
      cancelText: AppLocalizations.of(context)!.no,
      onConfirm: () {
        context.read<CancelOrderViewModel>().cancelOrder(orderId);
      },
    );
  }
}