import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/location/domain/use_cases/service_areas_use_case/get_service_areas_use_case/get_service_areas_use_case.dart';
import 'package:meayar_alitqan/features/location/presentation/manager/get_service_areas_view_model/get_service_areas_view_model_states.dart';
@injectable
class GetServiceAreasViewModel extends Cubit<GetServiceAreasViewModelStates> {
  final GetServiceAreasUseCase getServiceAreasUseCase;
  GetServiceAreasViewModel({required this.getServiceAreasUseCase})
    : super(GetServiceAreasViewModelInitial());

  Future<void> getServiceAreas() async {
    emit(GetServiceAreasViewModelLoading());
    final result = await getServiceAreasUseCase.call();
    emit(
      result.fold(
        (failure) => GetServiceAreasViewModelError(failure.message),
        (serviceAreasEntity) => GetServiceAreasViewModelSuccess(
           serviceAreasEntity,
        ),
      ),
    );
  }
}
