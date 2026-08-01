import 'package:flutter/material.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';

class OrderStepperHeader extends StatelessWidget {
  const OrderStepperHeader({
    super.key,
    required this.currentStep, 
    required this.stepLabels, 
  });

  final int currentStep;
  final List<String> stepLabels;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(stepLabels.length * 2 - 1, (index) {
        if (index.isOdd) {
          final leftStep = (index - 1) ~/ 2 + 1;
          final isLineActive = currentStep > leftStep;
          return Expanded(
            child: Container(
              height: 1.5,
              color: isLineActive
                  ? ColorsManager.primaryColor
                  : Colors.grey.shade300,
            ),
          );
        }

        final stepNumber = index ~/ 2 + 1;
        final label = stepLabels[stepNumber - 1];
        final isActive = stepNumber == currentStep;
        final isDone = stepNumber < currentStep;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: RS.size(context, 28),
              height: RS.size(context, 28),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (isActive || isDone)
                    ? ColorsManager.primaryColor
                    : Colors.white,
                border: Border.all(
                  color: (isActive || isDone)
                      ? ColorsManager.primaryColor
                      : ColorsManager.darkGrey,
                  width: 1.2,
                ),
              ),
              child: Text(
                "$stepNumber",
                style: TextStyle(
                  color: (isActive || isDone)
                      ? Colors.white
                      : ColorsManager.darkGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: RS.font(context, 13),
                ),
              ),
            ),
            SizedBox(height: RS.size(context, 4)),
            Text(
              label,
              style: TextStyle(
                fontSize: RS.font(context, 14),
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive
                    ? ColorsManager.primaryColor
                    : ColorsManager.darkGrey,
              ),
            ),
          ],
        );
      }),
    );
  }
}