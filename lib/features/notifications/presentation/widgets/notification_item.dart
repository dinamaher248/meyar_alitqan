import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/helper/time_ago_helper.dart';
import '../../../../core/utils/colors_manager.dart';
import '../../domain/entities/notification_entity.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.notification,

    this.icon,
  });

  final NotificationEntity notification;

  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:   EdgeInsets.symmetric(vertical:RS.size(context, 6) ),
      padding:   EdgeInsets.all(RS.size(context, 12)),
      decoration: BoxDecoration(
        color: notification.isRead
            ? Colors.white
            : ColorsManager.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(RS.radius(context, 12)),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _icon(context),

            SizedBox(width: RS.size(context, 12)),

          Expanded(child: _content(context)),
        ],
      ),
    );
  }

  Widget _icon(BuildContext context) {
    return Container(
      padding:   EdgeInsets.all(RS.size(context, 10)),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorsManager.primaryColor.withOpacity(0.15),
      ),
      child: Icon(
        icon ?? CupertinoIcons.bell,
        color: ColorsManager.primaryColor,
        size: RS.size(context, 20),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                notification.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: RS.font(context, 16),
                ),
              ),
            ),
            if (!notification.isRead)
              Container(
                width:RS.size(context, 8),
                height:RS.size(context, 8),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,

                ),
              ),
          ],
        ),

        const SizedBox(height: 6),

        Text(
          notification.body,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey[700],
            fontSize: RS.font(context, 14),
          ),
        ),

          SizedBox(height: RS.size(context, 8),),
        Text(
          timeAgo(notification.createdAt ,  Localizations.localeOf(context),),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey,
            fontSize: RS.font(context, 12),
          ),
        ),

      ],
    );
  }
}
