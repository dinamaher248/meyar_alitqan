import 'package:meayar_alitqan/features/services/domain/entities/request_priority_entity/request_priority_entity.dart';

abstract class GetRequestPriorityViewModelStates {}
class GetRequestPriorityViewModelInitial extends GetRequestPriorityViewModelStates {}
class GetRequestPriorityViewModelError extends GetRequestPriorityViewModelStates {
  final String message;
  GetRequestPriorityViewModelError(this.message);
}
class GetRequestPriorityViewModelSuccess extends GetRequestPriorityViewModelStates {
  final List<RequestPriorityEntity> requestPriorities;
  GetRequestPriorityViewModelSuccess(this.requestPriorities);
}

class GetRequestPriorityViewModelLoading extends GetRequestPriorityViewModelStates {}
