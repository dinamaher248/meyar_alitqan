import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/orders/technician/domain/use_cases/orders_use_case/update_order_status_use_case/update_order_status_use_case.dart';
import 'package:meayar_alitqan/features/orders/technician/presentation/manager/update_order_status_view_model/update_order_status_view_model_states.dart';
@injectable
class UpdateOrderStatusViewModel
    extends Cubit<UpdateOrderStatusViewModelStates> {
  final UpdateOrderStatusUseCase updateOrderStatusUseCase;

  UpdateOrderStatusViewModel(this.updateOrderStatusUseCase)
    : super(UpdateOrderStatusViewModelInitial());

  Future<void> updateOrderStatus({
    required String orderId,
    required String status,
  }) async {
    emit(UpdateOrderStatusViewModelLoading());
    final result = await updateOrderStatusUseCase.updateOrderStatus(
      orderId,
      status,
    );
    result.fold(
      (failure) => emit(UpdateOrderStatusViewModelError(failure.message)),
      (message) {
        if(!isClosed){
     emit(UpdateOrderStatusViewModelSuccess());
        }
      },
    );
  }
}
