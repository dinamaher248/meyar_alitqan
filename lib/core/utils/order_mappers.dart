import '../../features/orders/shared/data/models/order_model/order_model.dart';
import '../../features/orders/shared/domain/entities/order_entity/order_entity.dart';

extension OrderEntityMapper on OrderEntity {
  OrderModel toModel() {
    return OrderModel(
      id: id,
      customerId: customerId,
      technicianId: technicianId,
      mainCategoryId: mainCategoryId,
      categoryId: categoryId,
      subServiceId: subServiceId,
      title: title,
      description: description,
      location: location,
      images: images,
      videos: videos,
      level: level, // enum
      scheduledDate: scheduledDate,
      status: status, // enum
      price: price,
      adminNotes: adminNotes,
      createdAt: createdAt,
      updatedAt: updatedAt,
      technician: technician,
      locationUrl: locationUrl,
      customer: customer,
    );
  }
}
