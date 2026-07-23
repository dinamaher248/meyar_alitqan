import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';

class ServiceItemShimmer extends StatelessWidget {
  const ServiceItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(RS.size(context, 8)),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: RS.size(context, 12),
            vertical: RS.size(context, 16),
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorsManager.grey,
              width: RS.size(context, 3),
            ),
            borderRadius: BorderRadius.circular(RS.radius(context, 10)),
          ),
          child: Row(
            children: [
              _CircleShimmer(size: 50),
              SizedBox(width: RS.size(context, 16)),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _LineShimmer(width: double.infinity, height: 14),
                    SizedBox(height: RS.size(context, 8)),
                    _LineShimmer(width: 120, height: 12),
                    SizedBox(height: RS.size(context, 8)),
                    Row(
                      children: [
                        _LineShimmer(width: 40, height: 12),
                        SizedBox(width: RS.size(context, 6)),
                        _CircleShimmer(size: 12),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(width: RS.size(context, 12)),
              _CircleShimmer(size: 32),
            ],
          ),
        ),
      ),
    );
  }
}
class _LineShimmer extends StatelessWidget {
  final double width;
  final double height;

  const _LineShimmer({
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

class _CircleShimmer extends StatelessWidget {
  final double size;

  const _CircleShimmer({required this.size});

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
