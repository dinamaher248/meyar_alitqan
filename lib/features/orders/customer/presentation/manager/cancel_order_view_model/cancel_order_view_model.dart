import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../domain/use_cases/orders_use_cases/cancel_order_use_case/cancel_order_use_case.dart';
import 'cancel_order_view_model_states.dart';

@injectable
class CancelOrderViewModel extends Cubit<CancelOrderViewModelStates> {
  final CancelOrderUseCase cancelOrderUseCase;

  CancelOrderViewModel(this.cancelOrderUseCase)
    : super(CancelOrderViewModelInitial());

  Future<Either<Failures, void>> cancelOrder(String orderId) async {
    try {
      emit(CancelOrderViewModelLoading());
      final result = await cancelOrderUseCase.cancelOrder(orderId);
      result.fold(
        (failure) => emit(CancelOrderViewModelError(failure.message)),
        (success) => emit(CancelOrderViewModelSuccess()),
      );
      return result;
    } catch (e) {
      if (!isClosed) {
        emit(CancelOrderViewModelError(e.toString()));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
