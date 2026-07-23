import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/category_entity/category_entity.dart';
import '../../../domain/use_cases/categories_use_cases/get_services_by_sub_use_case/get_services_by_sub_use_case.dart';
import 'get_serives_by_sub_view_model_states.dart';

@injectable
class GetSerivesBySubViewModel extends Cubit<GetSerivesBySubViewModelStates> {
  final GetServicesBySubUseCase getServicesBySubUseCase;

  GetSerivesBySubViewModel(this.getServicesBySubUseCase)
    : super(GetSerivesBySubViewModelStatesInitial());

  Future<Either<Failures, List<CategoryEntity>>> getServicesBySub(
    String parentId,
  ) async {
    try {
      emit(GetSerivesBySubViewModelStatesLoading());
      final result = await getServicesBySubUseCase.call(parentId);
      result.fold(
        (failure) => emit(GetSerivesBySubViewModelStatesError(failure.message)),
        (categories) => emit(GetSerivesBySubViewModelStatesSuccess(categories)),
      );
      return result;
    } catch (e) {
      emit(GetSerivesBySubViewModelStatesError(e.toString()));
      return Left(ServerFailure(e.toString()));
    }
  }
}
