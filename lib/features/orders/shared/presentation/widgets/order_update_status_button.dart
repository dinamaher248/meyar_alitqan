import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/core/di/di.dart';
import 'package:meayar_alitqan/core/extensions/order_status.dart';
import 'package:meayar_alitqan/core/helper/responsive_size.dart';
import 'package:meayar_alitqan/core/utils/colors_manager.dart';
import '../../../technician/presentation/manager/update_order_status_view_model/update_order_status_view_model.dart';
import '../../../technician/presentation/manager/update_order_status_view_model/update_order_status_view_model_states.dart';
import '../../domain/entities/order_entity/order_entity.dart';

class OrderDetailsUpdateStatusButton extends StatelessWidget {
  final OrderEntity? order;

  const OrderDetailsUpdateStatusButton({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
   return BlocBuilder<
      UpdateOrderStatusViewModel,
      UpdateOrderStatusViewModelStates
    >(
      bloc: getIt<UpdateOrderStatusViewModel>(),
      builder: (context, state) {
        final isLoading = state is UpdateOrderStatusViewModelLoading;

        final currentStatus = order!.status;
        final nextStatus = currentStatus.nextStatus();

        if (nextStatus == null) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: InkWell(
            onTap: isLoading
                ? null
                : () {
                    context
                        .read<UpdateOrderStatusViewModel>()
                        .updateOrderStatus(
                          orderId: order!.id,
                          status: nextStatus.toApi(),
                        );
                  },
            child: ConstrainedBox(
              constraints: BoxConstraints(

                maxWidth:  RS.size(context, 420),
              ),
              child: Container(
                height: RS.size(context, 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(RS.radius(context, 10)),
                  border: Border.all(
                    color: ColorsManager.primaryColor,
                    width: RS.size(context, 2),
                  ),
                ),
                child: Center(
                  child: isLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          currentStatus.nextLocalized(context)!,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.primaryColor,
                            fontSize: 16
                          ),
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
 
}
}