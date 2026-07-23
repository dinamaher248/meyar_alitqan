import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/orders/shared/domain/entities/invoice_entity/invoice_entity.dart';
import 'package:meayar_alitqan/features/orders/shared/domain/repositories/invoice_repo/invoice_repo.dart';
@injectable
class  InvoiceUseCase {
  final InvoiceRepo invoiceRepo;
  InvoiceUseCase(this.invoiceRepo);

  Future<Either<Failures, InvoiceEntity>> call({required String orderId}) async {
    return await invoiceRepo.getInvoiceByOrderId(orderId: orderId);
  }
}