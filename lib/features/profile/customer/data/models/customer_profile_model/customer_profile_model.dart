import 'package:meayar_alitqan/features/profile/customer/domain/entities/customer_profile_entity/customer_profile_entity.dart';
import '../../../../shared/data/models/base_profile_model/base_profile_model.dart';
class CustomerProfileModel extends BaseProfileModel {
  CustomerProfileModel({
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

  CustomerProfileEntity toEntity() => CustomerProfileEntity(
        id: id,
        fullName: fullName,
        phone: phone,
        avatarUrl: avatarUrl,
        address: address,
        isActive: isActive,
        role: role,
        email: email,
        rating: rating
      );
}
