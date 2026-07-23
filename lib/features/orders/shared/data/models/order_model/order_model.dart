import 'package:meayar_alitqan/core/extensions/order_status.dart';

import '../../../../../../core/enums/request_priority.dart';
import '../../../../technician/data/models/order_technician_model/order_technician_model.dart';
import '../../../domain/entities/order_entity/order_entity.dart';
import '../order_customer_model/order_customer_model.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.customerId,
    super.technicianId,
    super.mainCategoryId,
    required super.categoryId,
    required super.subServiceId,
    required super.title,
    required super.description,
    required super.technician,
    required super.location,
    required super.locationUrl,
    required super.images,
    required super.videos,
    required super.level,
    super.scheduledDate,
    required super.status,
    super.price,
    super.adminNotes,
    required super.createdAt,
    required super.updatedAt,
    required super.customer,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      customerId: json['customer_id'],
      technicianId: json['technician_id'],
      mainCategoryId: json['main_category_id'],
      categoryId: json['category_id'],
      subServiceId: json['sub_service_id'],
      title: json['title'],
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      videos: List<String>.from(json['videos'] ?? []),
      level: RequestPriority.values.firstWhere(
        (e) => e.name == json['level'],
        orElse: () => RequestPriority.urgent,
      ),
      locationUrl: json['location_url'] ?? '',

      scheduledDate: json['scheduled_date'] != null
          ? DateTime.parse(json['scheduled_date'])
          : null,
      status: (json['status'] as String).toOrderStatus(),


      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      adminNotes: json['admin_notes'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),

      technician: json['technician'] != null
          ? OrderTechnicianModel.fromJson(
        Map<String, dynamic>.from(json['technician']),
      )
          : null,
      customer: json['customer'] != null
          ? OrderCustomerModel.fromJson(
        Map<String, dynamic>.from(json['customer']),
      )
          : null,

    );
  }

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      id: entity.id,
      customerId: entity.customerId,
      technicianId: entity.technicianId,
      mainCategoryId: entity.mainCategoryId,
      categoryId: entity.categoryId,
      subServiceId: entity.subServiceId,
      title: entity.title,
      description: entity.description,
      location: entity.location,
      images: entity.images,
      videos: entity.videos,
      level: entity.level,
      scheduledDate: entity.scheduledDate,
      status: entity.status,
      price: entity.price,
      adminNotes: entity.adminNotes,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      technician: entity.technician,
      locationUrl: entity.locationUrl,
      customer: entity.customer,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'technician_id': technicianId,
      'main_category_id': mainCategoryId,
      'category_id': categoryId,
      'sub_service_id': subServiceId,
      'title': title,
      'description': description,
      'location': location,
      'images': images,
      'videos': videos,


      'level': level.name,
      'status': status.name,
      'location_url': locationUrl,

      'scheduled_date': scheduledDate?.toIso8601String(),
      'price': price,
      'admin_notes': adminNotes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'technician': technician,
      'customer': customer,
    };
  }
}
