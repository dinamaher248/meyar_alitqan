import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/custom_app_bar.dart';
import '../../../../core/di/di.dart';
import '../../../../l10n/app_localizations.dart';
import '../manager/delete_notification_data_view_model/delete_notification_data_view_model.dart';
import '../manager/get_notifications_view_model/get_notifications_view_model.dart';
import '../manager/mark_notification_as_read_view_model/mark_notification_as_read_view_model.dart';
import '../manager/unread_notifications_count_view_model/unread_notifications_count_view_model.dart';
import '../widgets/notifications_view_body.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.notifications,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
            getIt<GetNotificationsViewModel>()..getNotifications(),
          ),
          BlocProvider(
            create: (_) =>
            getIt<MarkAllNotificationsAsReadViewModel>()

          ),
          BlocProvider(
            create: (_) =>
            getIt<UnreadNotificationsCountViewModel>()
          ),
          BlocProvider(
            create: (_) =>
            getIt<DeleteNotificationDataViewModel>()
          ),
        ],
        child: const NotificationsViewBody(),
      ),
    );
  }
}
