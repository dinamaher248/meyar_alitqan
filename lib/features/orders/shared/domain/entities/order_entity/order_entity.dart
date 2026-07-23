import '../../../../../../core/enums/order_status.dart';
import '../../../../../../core/enums/request_priority.dart';
import '../../../../technician/data/models/order_technician_model/order_technician_model.dart';
import '../../../data/models/order_customer_model/order_customer_model.dart';

class OrderEntity {
  final String id;
  final String customerId;
  final String? technicianId;
  final String ? mainCategoryId;
  final String categoryId;
  final String subServiceId;
  final String? title;
  final OrderTechnicianModel? technician;
  final OrderCustomerModel? customer;


  final String description;
  final String location;
  final String locationUrl;

  final List<String> images;
  final List<String> videos;
  final RequestPriority level; // order_level
  final DateTime? scheduledDate;
  final OrderStatus status; // order_status
  final double? price;
  final String? adminNotes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const OrderEntity({
    required this.id,
    required this.customerId,
    this.technicianId,
    this.customer,
    this.mainCategoryId,
    required this.categoryId,
    required this.location,
    required this.locationUrl,
    required this.subServiceId,
    required this.title,
    required this.description,
    required this.images,
    required this.videos,
    required this.level,
    this.scheduledDate,
    required this.status,
    this.price,
    this.adminNotes,
    required this.createdAt,
    required this.updatedAt,
    this.technician,
  });
}
