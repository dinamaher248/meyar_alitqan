class BaseProfileEntity {
  final String id;
  final String fullName;
  final String? phone;
  final String? email;
  final String? avatarUrl;
  final String? address;
  final bool isActive;
  final String role;
  final double? rating;

  const BaseProfileEntity({
    required this.id,
    required this.fullName,
    required this.email,
    this.phone,
    this.avatarUrl,
    this.address,
    required this.isActive,
    required this.role,
   required this.rating,
  });

  BaseProfileEntity copyWith({
    String? fullName,
    String? phone,
    String? email,
    String? avatarUrl,
    String? address,
    bool? isActive,
    String? role,
  }) {
    return BaseProfileEntity(
      id: id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      address: address ?? this.address,
      isActive: isActive ?? this.isActive,
      role: role ?? this.role,
      rating: rating,
    );
  }
 

}
