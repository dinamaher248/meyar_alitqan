import '../../../domain/entities/category_entity/category_entity.dart';

abstract class GetMainCategoriesViewModelStates {}
class GetMainCategoriesViewModelStatesInitial extends GetMainCategoriesViewModelStates {}
class GetMainCategoriesViewModelStatesLoading extends GetMainCategoriesViewModelStates {}
class GetMainCategoriesViewModelStatesSuccess extends GetMainCategoriesViewModelStates {
  final List<CategoryEntity> categories;
  GetMainCategoriesViewModelStatesSuccess(this.categories);
}
class GetMainCategoriesViewModelStatesError extends GetMainCategoriesViewModelStates {
  final String message;
  GetMainCategoriesViewModelStatesError(this.message);
}