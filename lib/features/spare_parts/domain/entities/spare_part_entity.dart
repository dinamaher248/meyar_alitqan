class SparePartEntity {
  final String id;
  final String orderId;
  final String technicianId;
  final String? adminId;

  final String partName;
  final String? partDescription;
  final int? quantity;

  final double? estimatedPrice;
  final double? approvedPrice;

  final String status;  
  final String? adminNote;

  final DateTime createdAt;
  final DateTime updatedAt;

  const SparePartEntity({
    required this.id,
    required this.orderId,
    required this.technicianId,
    this.adminId,
    required this.partName,
    this.partDescription,
    required this.quantity,
    this.estimatedPrice,
    this.approvedPrice,
    required this.status,
    this.adminNote,
    required this.createdAt,
    required this.updatedAt,
  });
}
