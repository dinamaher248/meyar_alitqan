import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../shared/domain/entities/order_entity/order_entity.dart';
import '../../../domain/use_cases/orders_use_cases/get_customer_orders_use_case/get_customer_orders_use_case.dart';
import 'get_customer_orders_view_model_states.dart';
@injectable
class GetCustomerOrdersViewModel extends Cubit<GetCustomerOrdersViewModelStates> {
  final GetCustomerOrdersUseCase getCustomerOrdersUseCase;
  GetCustomerOrdersViewModel(this.getCustomerOrdersUseCase) : super(GetCustomerOrdersViewModelInitial());

  Future<Either<Failures, List<OrderEntity>>> getCustomerOrders() async {
    try {
      emit(GetCustomerOrdersViewModelLoading());
      final result = await getCustomerOrdersUseCase.getCustomerOrders();
      result.fold(
        (failure) => emit(GetCustomerOrdersViewModelError(failure.message)),
        (success) => emit(GetCustomerOrdersViewModelSuccess(success)),
      );
      return result;
    } catch (e) {
       if(!isClosed) emit(GetCustomerOrdersViewModelError(e.toString()));
      return Left(ServerFailure(e.toString()));
    }
  }
}