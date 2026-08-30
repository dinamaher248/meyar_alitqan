import 'package:flutter/material.dart';

import '../../../../../../../../core/helper/responsive_size.dart';
import '../../../../../../../../core/utils/colors_manager.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class ReportDetailsSheet extends StatelessWidget {
  const ReportDetailsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.all(RS.size(context, 20)),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(loc.reportDetails,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: RS.font(context, 17),
              )),
          SizedBox(height: RS.size(context, 20)),

          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(loc.whatWasDone,
                style: TextStyle(
                  fontSize: RS.font(context, 13),
                  color: ColorsManager.secondaryTextDarkColor,
                )),
          ),
          SizedBox(height: RS.size(context, 6)),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "تم تركيب 4 كاميرات مراقبه خارجيه وبطها بجهاز تسجيل , مع اختبار جوده الصوره والتسجيل الليلي",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: RS.font(context, 13),
                color: ColorsManager.primaryTextDarkColor,
              ),
            ),
          ),

          SizedBox(height: RS.size(context, 18)),

          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(loc.totalCost,
                style: TextStyle(
                  fontSize: RS.font(context, 13),
                  color: ColorsManager.secondaryTextDarkColor,
                )),
          ),
          SizedBox(height: RS.size(context, 4)),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text("400 ${loc.currencyDinar}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: RS.font(context, 16),
                  color: ColorsManager.primaryTextDarkColor,
                )),
          ),

          SizedBox(height: RS.size(context, 18)),

          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(loc.photosAfterExecution,
                style: TextStyle(
                  fontSize: RS.font(context, 13),
                  color: ColorsManager.secondaryTextDarkColor,
                )),
          ),
          SizedBox(height: RS.size(context, 10)),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(RS.radius(context, 10)),
                child: Container(
                  width: RS.size(context, 90),
                  height: RS.size(context, 90),
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image, color: Colors.grey),
                ),
              ),
              SizedBox(width: RS.size(context, 10)),
              ClipRRect(
                borderRadius: BorderRadius.circular(RS.radius(context, 10)),
                child: Container(
                  width: RS.size(context, 90),
                  height: RS.size(context, 90),
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image, color: Colors.grey),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}