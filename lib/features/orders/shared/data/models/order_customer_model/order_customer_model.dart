class OrderCustomerModel {
  final String id;
  final String name;
  final String? phone;
  final String avatarUrl;

  const OrderCustomerModel({
    required this.id,
    required this.name,
    this.phone,
    required this.avatarUrl,
  });

  factory OrderCustomerModel.fromJson(Map<String, dynamic> json) {
    return OrderCustomerModel(
      id: json['id'],
      name: json['full_name'] ?? '',
      phone: json['phone']?.toString(),
      avatarUrl: json['avatar_url'] ?? '',
    );
  }
}
