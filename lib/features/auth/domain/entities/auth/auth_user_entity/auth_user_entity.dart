class AuthUserEntity {
  final String id;
  final String email;
  final String ? role;
  final String? fullName;
  final String? phone;
  final String? accessToken;
  final String? refreshToken;

  AuthUserEntity({
    required this.id,
    required this.email,
      this.role,
    this.fullName,
    this.phone,
    this.accessToken,
    this.refreshToken,
  });
}

