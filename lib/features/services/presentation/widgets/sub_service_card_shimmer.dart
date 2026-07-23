import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';

class SubServiceCardShimmer extends StatelessWidget {
  const SubServiceCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: RS.size(context, 12),
          vertical: RS.size(context, 16),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(RS.radius(context, 10)),
          border: Border.all(
            color: ColorsManager.grey,
            width: RS.size(context, 2),
          ),
        ),
        child: Row(
          children: [
            ShimmerCircle(size: RS.size(context, 40)),
            SizedBox(width: RS.size(context, 16)),

            Expanded(
              child: ShimmerLine(height: RS.size(context, 14)),
            ),

            SizedBox(width: RS.size(context, 16)),

            ShimmerIndicator(size: RS.size(context, 22)),
          ],
        ),
      ),
    );
  }
}
class ShimmerIndicator extends StatelessWidget {
  final double size;

  const ShimmerIndicator({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
class ShimmerLine extends StatelessWidget {
  final double height;
  final double? width;

  const ShimmerLine({
    super.key,
    required this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
class ShimmerCircle extends StatelessWidget {
  final double size;

  const ShimmerCircle({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
