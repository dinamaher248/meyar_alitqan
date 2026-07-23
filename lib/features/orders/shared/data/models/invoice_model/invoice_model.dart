 

import 'package:meayar_alitqan/features/orders/shared/data/models/invoice_item_model/invoice_item_model.dart';
import 'package:meayar_alitqan/features/orders/shared/domain/entities/invoice_entity/invoice_entity.dart';

class InvoiceModel extends InvoiceEntity {
  const InvoiceModel({
    required super.id,
    required super.invoiceNumber,
    required super.orderId,
    required super.clientName,
    required super.clientPhone,
    required super.clientAddress,
  

    required super.subtotal,
    required super.tax,
    required super.total,
    required super.currency,
    required super.status,
    required super.issuedAt,
    super.dueAt,
    required super.items,
  });

factory InvoiceModel.fromJson(Map<String, dynamic> json) {
  final rawItems = json['invoice_items'];

  return InvoiceModel(
    id: json['id']?.toString() ?? '',
    invoiceNumber: json['invoice_number']?.toString() ?? '',
    orderId: json['order_id']?.toString() ?? '',

    clientName: json['client_name']?.toString() ?? '',
    clientPhone: json['client_phone']?.toString() ?? '',
    clientAddress: json['client_address']?.toString(),

    subtotal: (json['subtotal'] is num)
        ? (json['subtotal'] as num).toDouble()
        : 0.0,

    tax: (json['tax'] is num)
        ? (json['tax'] as num).toDouble()
        : 0.0,

    total: (json['total'] is num)
        ? (json['total'] as num).toDouble()
        : 0.0,

    currency: json['currency']?.toString() ?? 'EGP',
    status: json['status']?.toString() ?? '',

    issuedAt: json['issued_at'] != null
        ? DateTime.parse(json['issued_at'])
        : DateTime.now(),

    dueAt: json['due_at'] != null
        ? DateTime.parse(json['due_at'])
        : null,

    items: rawItems is List
        ? rawItems
            .whereType<Map<String, dynamic>>()
            .map((e) => InvoiceItemModel.fromJson(e))
            .toList()
        : [],
  );
}


  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'client_name': clientName,
      'client_phone': clientPhone,
      'client_address': clientAddress,
      'subtotal': subtotal,
      'tax': tax,
      'total': total,
      'currency': currency,
      'status': status,
    };
  }
}
