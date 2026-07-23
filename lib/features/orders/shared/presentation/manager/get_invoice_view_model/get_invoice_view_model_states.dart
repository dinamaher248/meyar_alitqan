import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/orders/shared/domain/entities/invoice_entity/invoice_entity.dart';

abstract class GetInvoiceViewModelStates {}

class GetInvoiceViewModelInitial extends GetInvoiceViewModelStates {}

class GetInvoiceViewModelLoading extends GetInvoiceViewModelStates {}

class GetInvoiceViewModelError extends GetInvoiceViewModelStates {
  final Failures failure;
  GetInvoiceViewModelError(this.failure);
}

class GetInvoiceViewModelSuccess extends GetInvoiceViewModelStates {
  final InvoiceEntity invoice;
  GetInvoiceViewModelSuccess(this.invoice);
}