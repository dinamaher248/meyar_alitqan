import 'package:flutter/material.dart';

import '../../../../core/enums/request_priority.dart';
import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';
import '../../../../l10n/app_localizations.dart';

class OrderSummaryDetailsCard extends StatelessWidget {
  const OrderSummaryDetailsCard({
    super.key,
    required this.title,
    required this.location,
    required this.locationDetails,
    required this.description,
    required this.priority,
    required this.scheduledDate,
    required this.imagesCount,
  });

  final String? title;
  final String location;
  final String locationDetails;
  final String description;
  final RequestPriority priority;
  final DateTime? scheduledDate;
  final int imagesCount;

  String _priorityLabel(AppLocalizations t) {
    switch (priority) {
      case RequestPriority.scheduled:
        return t.scheduled;
      case RequestPriority.urgent:
        return t.urgent;
      case RequestPriority.emergency:
        return t.emergency;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(RS.size(context, 16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(RS.radius(context, 12)),
        border: Border.all(color: ColorsManager.grey, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null && title!.isNotEmpty) ...[
            Text(
              t.serviceName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: RS.font(context, 14)
                    ,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.darkGrey,
                  ),
            ),
            SizedBox(height: RS.size(context, 4)),
            Text(
              title!,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorsManager.primaryTextDarkColor,
                    fontSize: RS.font(context, 16),
                  ),
            ),
            SizedBox(height: RS.size(context, 14)),
          ],

          _field(context, t.location, "$location - $locationDetails"),
          SizedBox(height: RS.size(context, 12)),

          if (scheduledDate != null) ...[
            _field(
              context,
              t.serviceDate,
              "${scheduledDate!.day}/${scheduledDate!.month}/${scheduledDate!.year}",
            ),
            SizedBox(height: RS.size(context, 12)),
          ],

          _field(context, t.requestType, _priorityLabel(t)),
          SizedBox(height: RS.size(context, 12)),

          _field(context, t.description, description),

          if (imagesCount > 0) ...[
            SizedBox(height: RS.size(context, 12)),
            _field(context, t.uploadedPhotos, t.photosCount(imagesCount)),
          ],
        ],
      ),
    );
  }

  Widget _field(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: RS.font(context, 14)
                    ,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.darkGrey,
                  ),
        ),
        SizedBox(height: RS.size(context, 4)),
        Text(
          value,
           style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorsManager.primaryTextDarkColor,
                    fontSize: RS.font(context, 16),
                  ),
        ),
      ],
    );
  }
}