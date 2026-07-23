import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/orders/shared/domain/entities/invoice_entity/invoice_entity.dart';
import 'package:meayar_alitqan/features/orders/shared/domain/use_cases/invoice_use_case/invoice_use_case.dart';
import 'package:meayar_alitqan/features/orders/shared/presentation/manager/get_invoice_view_model/get_invoice_view_model_states.dart';

@injectable
class GetInvoiceViewModel extends Cubit<GetInvoiceViewModelStates> {
  final InvoiceUseCase getInvoiceUseCase;

  GetInvoiceViewModel(this.getInvoiceUseCase)
    : super(GetInvoiceViewModelInitial());

  Future<void> getInvoice(String orderId) async {
    try {
      emit(GetInvoiceViewModelLoading());
      Either<Failures, InvoiceEntity> response = await getInvoiceUseCase.call(
        orderId: orderId,
      );
      response.fold(
        (failure) => emit(GetInvoiceViewModelError(failure)),
        (invoice) => emit(GetInvoiceViewModelSuccess(invoice)),
      );
    } catch (e) {
      emit(GetInvoiceViewModelError(ServerFailure(e.toString())));
    }
  }
}
