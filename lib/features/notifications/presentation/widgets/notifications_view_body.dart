import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/core/helper/web_max_width.dart';

import '../manager/get_notifications_view_model/get_notifications_view_model.dart';
import '../manager/mark_notification_as_read_view_model/mark_notification_as_read_view_model.dart';
import '../manager/mark_notification_as_read_view_model/mark_notification_as_read_view_model_states.dart';
import '../manager/unread_notifications_count_view_model/unread_notifications_count_view_model.dart';
import 'notifications_list.dart';

class NotificationsViewBody extends StatefulWidget {
  const NotificationsViewBody({super.key});

  @override
  State<NotificationsViewBody> createState() =>
      _NotificationsViewBodyState();
}

class _NotificationsViewBodyState extends State<NotificationsViewBody> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MarkAllNotificationsAsReadViewModel>()
          .markAllNotificationsAsRead();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: BlocListener<
          MarkAllNotificationsAsReadViewModel,
          MarkNotificationAsReadViewModelStates>(
        listener: (context, state) {

          if (state is MarkNotificationAsReadViewModelSuccess) {


            context.read<GetNotificationsViewModel>().getNotifications();
            context.read<UnreadNotificationsCountViewModel>().load();
          }
        },
        child:   WebMaxWidth(child: NotificationsList()),
      ),
    );
  }
}
