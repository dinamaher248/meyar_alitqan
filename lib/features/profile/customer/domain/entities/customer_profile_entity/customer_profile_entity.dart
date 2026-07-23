

import '../../../../shared/domain/entities/base_profile_entity/base_profile_entity.dart';

class CustomerProfileEntity extends BaseProfileEntity {
  CustomerProfileEntity({
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
}
