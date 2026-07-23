import '../../../../../../core/errors/failures.dart';
import '../../../domain/entities/order_entity/order_entity.dart';

abstract class GetOrderDetailsViewModelStates {}
class GetOrderDetailsViewModelStatesInitial extends GetOrderDetailsViewModelStates {}
class GetOrderDetailsViewModelStatesSuccess extends GetOrderDetailsViewModelStates {
  final OrderEntity orderEntity;
  GetOrderDetailsViewModelStatesSuccess(this.orderEntity);
}
class GetOrderDetailsViewModelStatesError extends GetOrderDetailsViewModelStates {
  final Failures failures;
  GetOrderDetailsViewModelStatesError(this.failures);
}
class GetOrderDetailsViewModelStatesLoading extends GetOrderDetailsViewModelStates {}

