import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/auth/domain/use_cases/auth_use_cases/reset_password_use_case/reset_password_use_case.dart';
import 'package:meayar_alitqan/features/auth/presentation/manager/reset_password_view_model/reset_password_view_model_states.dart';

import '../../../../../../core/errors/failures.dart';
@injectable
class ResetPasswordViewModel extends Cubit<ResetPasswordViewModelStates> {
  final ResetPasswordUseCase resetPasswordUseCase;

  ResetPasswordViewModel(this.resetPasswordUseCase)
    : super(ResetPasswordViewModelInitial());

  Future<Either<Failures, void>> resetPassword({
    required String newPassword,
  }) async {
    try {
      emit(ResetPasswordViewModelLoading());
      final result = await resetPasswordUseCase.resetPassword(
        newPassword: newPassword,
      );
      result.fold(
        (failure) => emit(ResetPasswordViewModelError(message: failure.message)),
        (success) => emit(ResetPasswordViewModelSuccess()),
      );
      return result ;
    } catch (e) {
      emit(ResetPasswordViewModelError(message: e.toString()));
      return Left(ServerFailure(e.toString()));
    }
  }
}
