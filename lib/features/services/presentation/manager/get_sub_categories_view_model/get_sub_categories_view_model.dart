import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/services/domain/use_cases/categories_use_cases/get_services_by_sub_use_case/get_services_by_sub_use_case.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/category_entity/category_entity.dart';
import 'get_sub_categories_view_model_states.dart';
@injectable
class GetSubCategoriesViewModel extends Cubit<GetSubCategoriesViewModelStates>{
  final GetServicesBySubUseCase getServicesBySubUseCase ;

  GetSubCategoriesViewModel(this.getServicesBySubUseCase) : super(GetSubCategoriesViewModelStatesInitial());

  Future<Either<Failures, List<CategoryEntity>>> getSubCategories(String parentId) async {
     try {
      emit(GetSubCategoriesViewModelStatesLoading());
      final result = await getServicesBySubUseCase.call(parentId);
      result.fold(
        (failure) =>
            emit(GetSubCategoriesViewModelStatesError(failure.message)),
        (categories) =>
            emit(GetSubCategoriesViewModelStatesSuccess(categories)),
      );
      return result ;
    } catch (e) {
      emit(GetSubCategoriesViewModelStatesError(e.toString()));
      return Left(ServerFailure(e.toString()));
    }
  }
}