import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/orders/shared/domain/use_cases/get_order_details_use_case/get_order_details_use_case.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../domain/entities/order_entity/order_entity.dart';
import 'get_order_details_view_model_states.dart';
@injectable
class GetOrderDetailsViewModel extends Cubit<GetOrderDetailsViewModelStates> {
  final GetOrderDetailsUseCase getOrderDetailsUseCase;

  GetOrderDetailsViewModel(this.getOrderDetailsUseCase)
    : super(GetOrderDetailsViewModelStatesInitial());

  Future<Either<Failures, OrderEntity>> getOrderDetails(String orderId) async {
    try {
      emit(GetOrderDetailsViewModelStatesLoading());
      final result = await getOrderDetailsUseCase.getOrderDetails(orderId);
      result.fold(
        (failure) => emit(GetOrderDetailsViewModelStatesError(failure)),
        (order) => emit(GetOrderDetailsViewModelStatesSuccess(order)),
      );
      return result;
    } catch (e) {
      emit(GetOrderDetailsViewModelStatesError(ServerFailure(e.toString())));
      return Left(ServerFailure(e.toString()));
    }
  }
}
