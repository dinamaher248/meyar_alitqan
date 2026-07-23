import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/notifications/domain/use_cases/get_notifications_use_case/get_notifications_use_case.dart';

import 'get_notifications_view_model_states.dart';

@injectable
class GetNotificationsViewModel extends Cubit<GetNotificationsViewModelStates> {
  final GetNotificationsUseCase getNotificationsUseCase;

  GetNotificationsViewModel(this.getNotificationsUseCase)
    : super(GetNotificationsViewModelInitial());

  Future<void> getNotifications() async {
    emit(GetNotificationsViewModelLoading());
    final result = await getNotificationsUseCase.call();
    result.fold(
      (failure) => emit(GetNotificationsViewModelError(failure.message)),
          (notifications) {
        final filtered =
        notifications.where((n) => !n.isDeleted).toList();

        emit(GetNotificationsViewModelSuccess(filtered));
      },

    );
  }
  void removeNotificationLocally(String id) {
    if (state is GetNotificationsViewModelSuccess) {
      final current = state as GetNotificationsViewModelSuccess;
      final updatedList =
      current.notifications.where((n) => n.id != id).toList();

      emit(GetNotificationsViewModelSuccess(updatedList));
    }
  }

}
