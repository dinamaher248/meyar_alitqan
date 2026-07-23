import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/features/home/presentation/tabs/shared/widgets/guest_home_header.dart';
import 'package:meayar_alitqan/features/home/presentation/tabs/shared/widgets/notification_icon.dart';
import 'package:meayar_alitqan/features/home/presentation/tabs/shared/widgets/user_avatar_with_text_row.dart';

import '../../../../../../core/cubit/app_user/app_user_cubit.dart';
import '../../../../../notifications/presentation/manager/unread_notifications_count_view_model/unread_notifications_count_view_model.dart';
import '../../../../../notifications/presentation/manager/unread_notifications_count_view_model/unread_notifications_count_view_model_states.dart';
import '../../../../../profile/shared/domain/entities/base_profile_entity/base_profile_entity.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.onNotificationTap});

  final VoidCallback onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppUserCubit, BaseProfileEntity?>(
      builder: (context, user) {
        if (user == null) {
          return const GuestHomeHeader();
        }

        return _UserHomeHeader(onNotificationTap: onNotificationTap);
      },
    );
  }
}

class _UserHomeHeader extends StatelessWidget {
  const _UserHomeHeader({required this.onNotificationTap});

  final VoidCallback onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<AppUserCubit, BaseProfileEntity?>(
          builder: (context, user) {
            return UserAvatarWithTextRow(
              name: user!.fullName,
              role: user.address,
              avatar: user.avatarUrl ?? "",
            );
          },
        ),

        BlocBuilder<
          UnreadNotificationsCountViewModel,
          UnreadNotificationsCountViewModelStates
        >(
          builder: (context, state) {
            int count = 0;
            if (state is UnreadNotificationsCountViewModelSuccess) {
              count = state.unreadNotificationsCount;
            }

            return InkWell(
              onTap: onNotificationTap,
              child: NotificationIcon(count: count),
            );
          },
        ),
      ],
    );
  }
}
