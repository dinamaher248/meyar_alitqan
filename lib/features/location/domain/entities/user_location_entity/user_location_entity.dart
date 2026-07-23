class UserLocationEntity {
  final double latitude;
  final double longitude;
  final String? address;

  const UserLocationEntity({
    required this.latitude,
    required this.longitude,
    this.address,
  });
}
