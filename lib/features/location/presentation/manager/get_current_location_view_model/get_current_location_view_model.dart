import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/location/domain/use_cases/location_use_cases/get_current_location_use_case/get_current_location_use_case.dart';

import 'get_current_location_view_model_states.dart';
@injectable
class GetCurrentUserLocationViewModel
    extends Cubit<GetCurrentUserLocationViewModelStates> {
  final GetCurrentLocationUseCase getCurrentUserLocationUseCase;

  GetCurrentUserLocationViewModel({required this.getCurrentUserLocationUseCase})
    : super(GetCurrentUserLocationViewModelInitial());

  Future<void> getCurrentUserLocation() async {
    emit(GetCurrentUserLocationViewModelLoading());
    final result = await getCurrentUserLocationUseCase.call();
    result.fold(
      (failure) =>
          emit(GetCurrentUserLocationViewModelError(message: failure.message)),
      (userLocationEntity) => emit(
        GetCurrentUserLocationViewModelSuccess(
          userLocationEntity: userLocationEntity,
        ),
      ),
    );
  }
}
