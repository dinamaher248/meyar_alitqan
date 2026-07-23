import 'package:flutter/material.dart';
import 'package:meayar_alitqan/features/orders/customer/presentation/widgets/order_details_card_shimmer.dart';

class OrderDetailsListShimmer extends StatelessWidget {
  const OrderDetailsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, __) => const OrderDetailsCardShimmer(),
    );
  }
}
