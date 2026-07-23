class RegisterRequest {
  final String email;
  final String password;
  final String fullName;
  final String phone;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.fullName,
    required this.phone,
  });
}
