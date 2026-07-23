import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../domain/entities/base_profile_entity/base_profile_entity.dart';
import '../../../domain/use_cases/get_current_user_usecase/get_current_user_usecase.dart';
import 'get_current_user_view_model_states.dart';
@injectable
class GetCurrentUserViewModel extends Cubit<GetCurrentUserViewModelStates> {
  final GetCurrentUserUseCase getCurrentUserUseCase;

  GetCurrentUserViewModel(this.getCurrentUserUseCase)
    : super(GetCurrentUserViewModelInitial());
  final email = Supabase.instance.client.auth.currentUser?.email;

  Future<Either<Failures, BaseProfileEntity>> getCurrentUser({
    required String accessToken,
  }) async {
    try {
      emit(GetCurrentUserViewModelLoading());
      final result = await getCurrentUserUseCase.getCurrentUser(
        accessToken: accessToken,
      );
      result.fold(
        (failure) =>
            emit(GetCurrentUserViewModelError(message: failure.message)),
        (baseProfileEntity) => emit(
          GetCurrentUserViewModelSuccess(baseProfileEntity: baseProfileEntity),
        ),
      );
      return result;
    } catch (e) {
      emit(GetCurrentUserViewModelError(message: e.toString()));
      return Left(ServerFailure(e.toString()));
    }
  }
}
