import 'package:flutter/material.dart';

import '../../../../../../../../core/helper/responsive_size.dart';
import '../../../../../../../../core/utils/colors_manager.dart';

class ServiceSummaryTile extends StatelessWidget {
  const ServiceSummaryTile({
    super.key,
    required this.title,
    required this.orderNumber,
    required this.date,
    required this.onTap,
  });

  final String title;
  final String orderNumber;
  final String date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(RS.radius(context, 12)),
      child: Container(
        padding: EdgeInsets.all(RS.size(context, 14)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(RS.radius(context, 12)),
          border: Border.all(color: ColorsManager.grey),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(RS.size(context, 6)),
              decoration: BoxDecoration(
                color: const Color(0xffFFF4E5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.bolt,
                color: Colors.orange,
                size: RS.size(context, 16),
              ),
            ),
            SizedBox(width: RS.size(context, 8)),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: RS.font(context, 14),
                    ),
                  ),
                  SizedBox(height: RS.size(context, 4)),
                  Row(
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: RS.font(context, 11),
                          color: ColorsManager.secondaryTextDarkColor,
                        ),
                      ),
                      Text(
                        orderNumber,
                        style: TextStyle(
                          fontSize: RS.font(context, 11),
                          color: ColorsManager.secondaryTextDarkColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: RS.size(context, 6)),
            Icon(
              Icons.chevron_right,
              color: ColorsManager.secondaryTextDarkColor,
              size: RS.size(context, 18),
            ),
          ],
        ),
      ),
    );
  }
}
