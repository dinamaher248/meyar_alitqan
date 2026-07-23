import '../../../domain/entities/category_entity/category_entity.dart';

abstract class GetSerivesBySubViewModelStates {}

class GetSerivesBySubViewModelStatesInitial extends GetSerivesBySubViewModelStates {}

class GetSerivesBySubViewModelStatesLoading extends GetSerivesBySubViewModelStates {}

class GetSerivesBySubViewModelStatesSuccess extends GetSerivesBySubViewModelStates {
  final List<CategoryEntity> categories;
  GetSerivesBySubViewModelStatesSuccess(this.categories);
}

class GetSerivesBySubViewModelStatesError extends GetSerivesBySubViewModelStates {
  final String message;
  GetSerivesBySubViewModelStatesError(this.message);
}
