import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/auth/presentation/manager/save_fcm_token_view_model/save_fcm_token_view_model_states.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/use_cases/auth_use_cases/save_fcm_token_usecase/save_fcm_token_usecase.dart';

@injectable
class SaveFcmTokenViewModel extends Cubit<SaveFcmTokenViewModelStates> {
  final SaveFcmTokenUseCase saveFcmTokenUseCase;

  SaveFcmTokenViewModel(this.saveFcmTokenUseCase)
    : super(SaveFcmTokenViewModelInitial());

  Future<Either<Failures, bool>> saveFcmToken({
    required String token,
    required String platform,
  }) async {
    try {
      emit(SaveFcmTokenViewModelLoading());

      final result = await saveFcmTokenUseCase.saveFcmToken(
        token: token,
        platform: platform,
      );

      result.fold(
        (failure) => emit(SaveFcmTokenViewModelError(message: failure.message)),
        (_) => emit(SaveFcmTokenViewModelSuccess()),
      );

      return result;
    } catch (e) {
      emit(SaveFcmTokenViewModelError(message: e.toString()));
      return Left(ServerFailure(e.toString()));
    }
  }
}
