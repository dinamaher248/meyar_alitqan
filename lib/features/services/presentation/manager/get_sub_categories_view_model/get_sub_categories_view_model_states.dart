import '../../../domain/entities/category_entity/category_entity.dart';

abstract class GetSubCategoriesViewModelStates {}

class GetSubCategoriesViewModelStatesInitial extends GetSubCategoriesViewModelStates {}
class GetSubCategoriesViewModelStatesLoading extends GetSubCategoriesViewModelStates {}
class GetSubCategoriesViewModelStatesSuccess extends GetSubCategoriesViewModelStates {
  final List<CategoryEntity> categories;
  GetSubCategoriesViewModelStatesSuccess(this.categories);
}
class GetSubCategoriesViewModelStatesError extends GetSubCategoriesViewModelStates {
  final String message;
  GetSubCategoriesViewModelStatesError(this.message);
}
