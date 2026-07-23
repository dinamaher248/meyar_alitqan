import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';

class SubCategoryCardShimmer extends StatelessWidget {
  const SubCategoryCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(RS.radius(context, 10)),
          border: Border.all(
            color: ColorsManager.grey,
            width: 1,
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: RS.size(context, 12),
          horizontal: RS.size(context, 8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: RS.size(context, 32),
              height: RS.size(context, 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(RS.radius(context, 6)),
              ),
            ),
            SizedBox(height: RS.size(context, 8)),
            Container(
              width: RS.size(context, 50),
              height: RS.size(context, 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}