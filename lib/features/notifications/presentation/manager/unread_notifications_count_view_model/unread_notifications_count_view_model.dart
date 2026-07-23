import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/notifications/presentation/manager/unread_notifications_count_view_model/unread_notifications_count_view_model_states.dart';

import '../../../domain/use_cases/unread_notifications_count_use_case/unread_notifications_count_use_case.dart';
@injectable
class UnreadNotificationsCountViewModel
    extends Cubit<UnreadNotificationsCountViewModelStates> {

  final UnreadNotificationsCountUseCase useCase;

  UnreadNotificationsCountViewModel(this.useCase)
      : super(UnreadNotificationsCountViewModelInitial());

  Future<void> load() async {
    if (isClosed) return;

    emit(UnreadNotificationsCountViewModelLoading());

    final result = await useCase.call();

    if (isClosed) return;

    result.fold(
      (failure) {
        if (!isClosed) {
          emit(UnreadNotificationsCountViewModelError(failure.message));
        }
      },
      (count) {
        if (!isClosed) {
          emit(UnreadNotificationsCountViewModelSuccess(count));
        }
      },
    );
  }
}
