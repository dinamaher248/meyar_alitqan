enum UserRole {
  customer,
  technician,
}

extension UserRoleX on UserRole {
  String get name {
    switch (this) {
      case UserRole.customer:
        return 'customer';
      case UserRole.technician:
        return 'technician';
    }
  }

  static UserRole? fromString(String? value) {
    switch (value) {
      case 'customer':
        return UserRole.customer;
      case 'technician':
        return UserRole.technician;
      default:
        return null;
    }
  }
}
