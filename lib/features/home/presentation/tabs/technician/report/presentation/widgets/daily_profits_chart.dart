import 'package:flutter/material.dart';

import '../../../../../../../../core/helper/responsive_size.dart';
import '../../../../../../../../core/utils/colors_manager.dart';

class DailyProfitsChart extends StatelessWidget {
  const DailyProfitsChart({
    super.key,
    required this.values, // 0.0 -> 1.0
    required this.dayLabels,
  });

  final List<double> values;
  final List<String> dayLabels;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: RS.size(context, 130),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(values.length, (index) {
          final isHighest = values[index] == values.reduce((a, b) => a > b ? a : b);
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: RS.size(context, 90) * values[index],
                  margin: EdgeInsets.symmetric(horizontal: RS.size(context, 3)),
                  decoration: BoxDecoration(
                    color: isHighest
                        ? ColorsManager.primaryColor
                        : ColorsManager.primaryColor.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(RS.radius(context, 6)),
                  ),
                ),
                SizedBox(height: RS.size(context, 8)),
                Text(
                  dayLabels[index],
                  style: TextStyle(
                    fontSize: RS.font(context, 9),
                    color: ColorsManager.secondaryTextDarkColor,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}