import '../../../../domain/entities/auth/auth_user_entity/auth_user_entity.dart';

class AuthUserModel extends AuthUserEntity {
  AuthUserModel({
    required super.id,
    required super.email,
    super.fullName,
    super.phone,
      super.role,
    super.accessToken,
    super.refreshToken,
  });



  factory AuthUserModel.fromLoginJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['user']['id'],
      email: json['user']['email'],
      role: null,
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  factory AuthUserModel.fromRegisterJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['user']['id'],
      email: json['user']['email'],
      role: json['user']['role'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'phone': phone,
      'role': role,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}
