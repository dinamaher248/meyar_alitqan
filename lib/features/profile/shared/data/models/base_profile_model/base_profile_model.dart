import '../../../domain/entities/base_profile_entity/base_profile_entity.dart';

class BaseProfileModel extends BaseProfileEntity {
  BaseProfileModel({
    required super.id,
    required super.fullName,
    super.phone,
    super.avatarUrl,
    super.address,
    required super.isActive,
    required super.role,
    required super.email,
    required super.rating
  });

  factory BaseProfileModel.fromJson(Map<String, dynamic> json) {
    return BaseProfileModel(
      id: json['id'],
      fullName: json['full_name'],
      phone: json['phone'],
      avatarUrl: json['avatar_url'],
      address: json['address'],
      isActive: json['is_active'] ?? true,
      role: json['role'],
      email: json['email'],
        rating: (json['rating'] as num?)?.toDouble(),
    );
  }
  
}
