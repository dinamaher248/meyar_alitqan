import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/services/domain/use_cases/categories_use_cases/get_main_categories_use_case/get_main_categories_use_case.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/category_entity/category_entity.dart';
import 'get_main_categories_view_model_states.dart';

@injectable
class GetMainCategoriesViewModel
    extends Cubit<GetMainCategoriesViewModelStates> {
  final GetMainCategoriesUseCase getMainCategoriesUseCase;

  GetMainCategoriesViewModel(this.getMainCategoriesUseCase)
      : super(GetMainCategoriesViewModelStatesInitial());

  List<CategoryEntity>? _cachedCategories;
  String _lastQuery = '';

  Future<void> getMainCategories({bool forceRefresh = false}) async {
    
    if (_cachedCategories != null && !forceRefresh) {
      emit(GetMainCategoriesViewModelStatesSuccess(
        _applySearch(_lastQuery, _cachedCategories!),
      ));
      return;
    }

    emit(GetMainCategoriesViewModelStatesLoading());

    final result = await getMainCategoriesUseCase.call();

    result.fold(
      (failure) {
        emit(GetMainCategoriesViewModelStatesError(failure.message));
      },
      (categories) {
        _cachedCategories = categories;

        emit(GetMainCategoriesViewModelStatesSuccess(
          _applySearch(_lastQuery, categories),
        ));
      },
    );
  }

  void search(String query) {
    _lastQuery = query;

    if (_cachedCategories == null) return;

    emit(GetMainCategoriesViewModelStatesSuccess(
      _applySearch(query, _cachedCategories!),
    ));
  }

  List<CategoryEntity> _applySearch(
    String query,
    List<CategoryEntity> list,
  ) {
    if (query.isEmpty) return List<CategoryEntity>.from(list);

    return list
        .where(
          (c) => c.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  void clearCache() {
    _cachedCategories = null;
    _lastQuery = '';
  }
}
