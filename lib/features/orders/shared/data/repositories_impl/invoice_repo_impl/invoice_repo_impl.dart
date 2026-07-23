import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/orders/shared/data/data_sources/remote/invoice_remote_data_source/invoice_remote_data_source.dart';
import 'package:meayar_alitqan/features/orders/shared/domain/entities/invoice_entity/invoice_entity.dart';
import 'package:meayar_alitqan/features/orders/shared/domain/repositories/invoice_repo/invoice_repo.dart';
@Injectable(as: InvoiceRepo)
class InvoiceRepoImpl implements InvoiceRepo{
  final InvoiceRemoteDataSource invoiceRemoteDataSource;
  InvoiceRepoImpl({required this.invoiceRemoteDataSource});
  @override
  Future<Either<Failures, InvoiceEntity>> getInvoiceByOrderId({required String orderId}) {
    return invoiceRemoteDataSource.getInvoiceByOrderId(orderId: orderId);
  }
}