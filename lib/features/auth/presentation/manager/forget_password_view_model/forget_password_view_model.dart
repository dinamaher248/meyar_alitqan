import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../domain/use_cases/auth_use_cases/forget_password_use_case/forget_password_use_case.dart';
import 'forget_password_view_model_states.dart';
@injectable
class ForgetPasswordViewModel extends Cubit<ForgetPasswordViewModelStates> {
  final ForgetPasswordUseCase forgetPasswordUseCase;

  ForgetPasswordViewModel(this.forgetPasswordUseCase)
    : super(ForgetPasswordViewModelInitial());

  Future<Either<Failures, void>> forgetPassword({required String email}) async {
    try {
      emit(ForgetPasswordViewModelLoading());
      final result = await forgetPasswordUseCase.sendResetLink(email);
      result.fold(
        (failure) =>
            emit(ForgetPasswordViewModelError(message: failure.message)),
        (success) => emit(ForgetPasswordViewModelSuccess()),
      );
      return result;
    } catch (e) {
      emit(ForgetPasswordViewModelError(message: e.toString()));
      return Left(ServerFailure(e.toString()));
    }
  }
}
