import 'package:flutter/material.dart';

import '../../../../../../../../core/helper/responsive_size.dart';
import '../../../../../../../../core/utils/colors_manager.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class WeeklyProfitHeader extends StatelessWidget {
  const WeeklyProfitHeader({
    super.key,
    required this.totalAmount,
    required this.increasePercent,
  });

  final String totalAmount;
  final String increasePercent;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(RS.size(context, 18)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorsManager.primaryColor,
            ColorsManager.primaryColor.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(RS.radius(context, 16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             
              Text(
                loc.totalProfitsThisWeek,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: RS.font(context, 13),
                ),
              ),
               Container(
                padding: EdgeInsets.symmetric(
                  horizontal: RS.size(context, 10),
                  vertical: RS.size(context, 6),
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(RS.radius(context, 20)),
                ),
                child: Row(
                  children: [
                    Text(
                      loc.week,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const Icon(Icons.keyboard_arrow_down,
                        color: Colors.white, size: 16),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: RS.size(context, 16)),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: totalAmount,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: RS.font(context, 28),
                    ),
                  ),
                  TextSpan(
                    text: "  ${loc.currencyDinar}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: RS.font(context, 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: RS.size(context, 12)),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: RS.size(context, 10),
                vertical: RS.size(context, 4),
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(RS.radius(context, 20)),
              ),
              child: Text(
                "$increasePercent ${loc.increaseFromLastWeek}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: RS.font(context, 11),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}