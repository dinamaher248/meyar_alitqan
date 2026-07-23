 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/notifications/presentation/manager/send_notifications_view_model/send_notifications_view_model_states.dart';

import '../../../domain/use_cases/send_notifications_use_case/send_notifications_use_case.dart';
@injectable
class SendNotificationsViewModel extends Cubit<SendNotificationsViewModelStates>{
  final SendNotificationsUseCase sendNotificationsUseCase;
  SendNotificationsViewModel(this.sendNotificationsUseCase) : super(SendNotificationsViewModelInitial());

  Future<void> sendNotifications({required String title, required String body}) async {
    emit(SendNotificationsViewModelLoading());
    final result = await sendNotificationsUseCase.call(title: title, body: body);
    result.fold(
      (failure) => emit(SendNotificationsViewModelError(failure.message)),
      (notifications) => emit(SendNotificationsViewModelSuccess()),
    );
  }

}