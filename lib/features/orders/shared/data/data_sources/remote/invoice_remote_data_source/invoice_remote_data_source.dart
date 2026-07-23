import 'package:either_dart/either.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/orders/shared/domain/entities/invoice_entity/invoice_entity.dart';

abstract class InvoiceRemoteDataSource {
  Future<Either<Failures, InvoiceEntity>> getInvoiceByOrderId({
    required String orderId,
  });
}
