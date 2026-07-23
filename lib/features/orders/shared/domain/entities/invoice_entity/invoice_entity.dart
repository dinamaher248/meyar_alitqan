
import 'package:meayar_alitqan/features/orders/shared/domain/entities/invoice_item_entity/invoice_item_entity.dart';

class InvoiceEntity {
  final String id;
  final String invoiceNumber;
  final String orderId;

  final String clientName;
  final String clientPhone;
  final String? clientAddress;

  final double subtotal;
  final double tax;
  final double total;
  final String currency;

  final String status;
  final DateTime issuedAt;
  final DateTime? dueAt;

  final List<InvoiceItemEntity> items;

  const InvoiceEntity({
    required this.id,
    required this.invoiceNumber,
    required this.orderId,
    required this.clientName,
    required this.clientPhone,
    this.clientAddress,
    required this.subtotal,
    required this.tax,
    required this.total,
    required this.currency,
    required this.status,
    required this.issuedAt,
    this.dueAt,
    required this.items,
  });
}
