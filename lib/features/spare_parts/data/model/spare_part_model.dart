import '../../domain/entities/spare_part_entity.dart';

class SparePartModel extends SparePartEntity {
  const SparePartModel({
    required super.id,
    required super.orderId,
    required super.technicianId,
    super.adminId,
    required super.partName,
    super.partDescription,
    required super.quantity,
    super.estimatedPrice,
    super.approvedPrice,
    required super.status,
    super.adminNote,
    required super.createdAt,
    required super.updatedAt,
  });

  factory SparePartModel.fromJson(Map<String, dynamic> json) {
    return SparePartModel(
      id: json['id'],
      orderId: json['order_id'],
      technicianId: json['technician_id'],
      adminId: json['admin_id'],
      partName: json['part_name'],
      partDescription: json['part_description'],
      quantity: json['quantity'] ?? 1,
      estimatedPrice: (json['estimated_price'] as num?)?.toDouble(),
      approvedPrice: (json['approved_price'] as num?)?.toDouble(),
      status: json['status'],
      adminNote: json['admin_note'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "order_id": orderId,
      "part_name": partName,
      "part_description": partDescription,
      "quantity": quantity,
      "estimated_price": estimatedPrice,
    };
  }
}
