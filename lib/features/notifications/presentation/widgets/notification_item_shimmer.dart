import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/helper/responsive_size.dart';

class NotificationItemShimmer extends StatelessWidget {
  const NotificationItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: RS.size(context, 6)),
        padding: EdgeInsets.all(RS.size(context, 12)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(RS.radius(context, 12)),
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _iconShimmer(context),
            SizedBox(width: RS.size(context, 12)),
            Expanded(child: _contentShimmer(context)),
          ],
        ),
      ),
    );
  }

  Widget _iconShimmer(BuildContext context) {
    return Container(
      width: RS.size(context, 40),
      height: RS.size(context, 40),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _contentShimmer(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Container(
          height: RS.size(context, 16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),

        SizedBox(height: RS.size(context, 8)),

        // Body line 1
        Container(
          height: RS.size(context, 14),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),

        SizedBox(height: RS.size(context, 6)),

        // Body line 2
        Container(
          height: RS.size(context, 14),
          width: RS.size(context, 220),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),

        SizedBox(height: RS.size(context, 10)),

        // Date
        Container(
          height: RS.size(context, 12),
          width: RS.size(context, 120),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}
