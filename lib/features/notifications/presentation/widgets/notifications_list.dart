import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../l10n/app_localizations.dart';
import '../manager/delete_notification_data_view_model/delete_notification_data_view_model.dart';
import '../manager/delete_notification_data_view_model/delete_notification_data_view_model_states.dart';
import '../manager/get_notifications_view_model/get_notifications_view_model.dart';
import '../manager/get_notifications_view_model/get_notifications_view_model_states.dart';
import 'notification_item.dart';
import 'notification_list_shimmer.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      DeleteNotificationDataViewModel,
      DeleteNotificationDataViewModelStates
    >(
      listener: (context, deleteState) {
        if (deleteState is DeleteNotificationDataViewModelError) {
          context.read<GetNotificationsViewModel>().getNotifications();
        }

        if (deleteState is DeleteNotificationDataViewModelSuccess) {}
      },
      builder: (context, deleteState) {
        return BlocBuilder<
          GetNotificationsViewModel,
          GetNotificationsViewModelStates
        >(
          builder: (context, state) {
            if (state is GetNotificationsViewModelLoading) {
              return NotificationsListShimmer();
            }

            if (state is GetNotificationsViewModelError) {
              return Center(child: Text(state.message));
            }

            if (state is GetNotificationsViewModelSuccess) {
              if (state.notifications.isEmpty) {
                return _emptyState(context);
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.notifications.length,
                itemBuilder: (context, index) {
                  final notification = state.notifications[index];

                  return Dismissible(
                    key: ValueKey(notification.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.red,
                      child: const Icon(Icons.delete, color: Colors.white, size: 16,),
                    ),
                    onDismissed: (_) {
                      // 1️⃣ remove from UI immediately
                      context
                          .read<GetNotificationsViewModel>()
                          .removeNotificationLocally(notification.id);

                      // 2️⃣ call API
                      context
                          .read<DeleteNotificationDataViewModel>()
                          .deleteNotificationData(notification.id);
                    },

                    child: NotificationItem(notification: notification),
                  );
                },
              );
            }

            return const SizedBox();
          },
        );
      },
    );
  }

  Widget _emptyState(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetsManager.noNotification,
            height: RS.size(context, 200),
          ),
          SizedBox(height: RS.size(context, 16)),
          Text(
            AppLocalizations.of(context)!.noNotifications,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: RS.font(context, 20),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
