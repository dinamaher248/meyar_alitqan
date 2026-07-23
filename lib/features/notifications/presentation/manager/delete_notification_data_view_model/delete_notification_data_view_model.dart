import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/use_cases/delete_notification_data_use_case/delete_notification_data_use_case.dart';
import 'delete_notification_data_view_model_states.dart';
@injectable
class DeleteNotificationDataViewModel
    extends Cubit<DeleteNotificationDataViewModelStates> {
  final DeleteNotificationDataUseCase deleteNotificationDataUseCase;

  DeleteNotificationDataViewModel(this.deleteNotificationDataUseCase)
    : super(DeleteNotificationDataViewModelInitial());

  Future<Either<Failures, void>> deleteNotificationData(
    String notificationId,
  ) async {
    try {
      emit(DeleteNotificationDataViewModelLoading());
      final result = await deleteNotificationDataUseCase.deleteNotificationData(
        notificationId,
      );
      result.fold(
        (failure) =>
            emit(DeleteNotificationDataViewModelError(failure: failure)),
        (success) => emit(DeleteNotificationDataViewModelSuccess()),
      );
      return Right(null);
    } catch (e) {
      emit(
        DeleteNotificationDataViewModelError(
          failure: ServerFailure(e.toString()),
        ),
      );
      return Left(ServerFailure(e.toString()));
    }
  }

}
