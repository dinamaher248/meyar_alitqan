class InvoiceItemEntity {
  final String id;
  final String invoiceId;
  final String type; // spare_part | service
  final String description;
  final int quantity;
  final double unitPrice;
  final double total;

  const InvoiceItemEntity({
    required this.id,
    required this.invoiceId,
    required this.type,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.total,
  });
}
