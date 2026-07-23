 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/notifications/presentation/manager/mark_notification_as_read_view_model/mark_notification_as_read_view_model_states.dart';

import '../../../domain/use_cases/mark_notification_as_read_use_case/mark_notification_as_read_use_case.dart';
@injectable
@injectable
class MarkAllNotificationsAsReadViewModel
    extends Cubit<MarkNotificationAsReadViewModelStates> {

  final MarkNotificationAsReadUseCase useCase;

  MarkAllNotificationsAsReadViewModel(this.useCase)
      : super(MarkNotificationAsReadViewModelInitial());

  Future<void> markAllNotificationsAsRead() async {
    if (isClosed) return; // 🔥 الحل

    emit(MarkNotificationAsReadViewModelLoading());

    final result = await useCase.call();

    if (isClosed) return; // 🔥 مهم جدًا

    result.fold(
          (failure) {
        if (!isClosed) {
          emit(MarkNotificationAsReadViewModelError(failure.message));
        }
      },
          (_) {
        if (!isClosed) {
          emit(MarkNotificationAsReadViewModelSuccess());
        }
      },
    );
  }
}
