import 'package:flutter/material.dart';
import '../../../../../core/helper/responsive_size.dart';
import 'shimmer_box.dart';

class OrderDetailsCardShimmer extends StatelessWidget {
  const OrderDetailsCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: RS.size(context, 12),
        vertical: RS.size(context, 8),
      ),
      child: Container(
        padding: EdgeInsets.all(RS.size(context, 12)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(RS.radius(context, 10)),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ShimmerBox(width: 120, height: 16),
                ShimmerBox(width: 60, height: 16),
              ],
            ),

            SizedBox(height: RS.size(context, 16)),

            /// Meta info (3 items)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ShimmerBox(width: 80, height: 50),
                ShimmerBox(width: 80, height: 50),
                ShimmerBox(width: 80, height: 50),
              ],
            ),

            SizedBox(height: RS.size(context, 16)),

            /// Expand arrow
            const Center(
              child: ShimmerBox(width: 40, height: 10),
            ),
          ],
        ),
      ),
    );
  }
}
