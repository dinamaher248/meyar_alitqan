import 'package:flutter/cupertino.dart';

import '../../../../core/helper/responsive_size.dart';
import 'notification_item_shimmer.dart';

class NotificationsListShimmer extends StatelessWidget {
  const NotificationsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(RS.size(context, 8)),
      itemCount: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

      itemBuilder: (context, index) {
        return const NotificationItemShimmer();
      },
    );
  }
}
