// lib/features/services/domain/entities/service_offer_entity.dart

class ServiceOfferEntity {
  final String id;
  final String title;
  final String imageUrl;
  final double rating;
  final int satisfiedCustomersCount;
  final double? price;
  final String? categoryId;

  const ServiceOfferEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.satisfiedCustomersCount,
    this.price,
    this.categoryId,
  });

  /// هيتستخدم لما نربط بالـ Edge Function (الرد بييجي JSON بنفس الشكل ده)
  factory ServiceOfferEntity.fromMap(Map<String, dynamic> map) {
    return ServiceOfferEntity(
      id: map['id'].toString(),
      title: map['title'] as String,
      imageUrl: map['image_url'] as String,
      rating: (map['rating'] as num?)?.toDouble() ?? 0,
      satisfiedCustomersCount: map['satisfied_customers_count'] as int? ?? 0,
      price: (map['price'] as num?)?.toDouble(),
      categoryId: map['category_id']?.toString(),
    );
  }
}