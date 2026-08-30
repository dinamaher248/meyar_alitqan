import 'package:flutter/material.dart';

import '../../../../../../../../core/helper/responsive_size.dart';
import '../../../../../../../../core/utils/colors_manager.dart';

class ServiceProfitRow extends StatelessWidget {
  const ServiceProfitRow({
    super.key,
    required this.serviceName,
    required this.amount,
    required this.progress,
  });

  final String serviceName;
  final String amount;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              serviceName,
              style: TextStyle(
                fontSize: RS.font(context, 13),
                fontWeight: FontWeight.w600,
                color: ColorsManager.primaryTextDarkColor,
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                fontSize: RS.font(context, 13),
                fontWeight: FontWeight.bold,
                color: ColorsManager.primaryTextDarkColor,
              ),
            ),
          ],
        ),
        SizedBox(height: RS.size(context, 8)),
        ClipRRect(
          borderRadius: BorderRadius.circular(RS.radius(context, 10)),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: RS.size(context, 8),
            backgroundColor: ColorsManager.grey,
            valueColor: const AlwaysStoppedAnimation(Color(0xffCE9524)),
          ),
        ),
      ],
    );
  }
}