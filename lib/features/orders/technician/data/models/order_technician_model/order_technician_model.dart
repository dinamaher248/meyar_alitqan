class OrderTechnicianModel {
  final String id;
  final String name;
  final String? avatarUrl;
  final double rating;
  final int completedOrders;
  final bool isVerified;

  OrderTechnicianModel({
    required this.id,
    required this.name,
    this.avatarUrl,
    required this.rating,
    required this.completedOrders,
    required this.isVerified,
  });

  factory OrderTechnicianModel.fromJson(Map<String, dynamic> json) {
    return OrderTechnicianModel(
      id: json['id'],
      name: json['name'],
      avatarUrl: json['avatarUrl'],
      rating: (json['rating'] ?? 0).toDouble(),
      completedOrders: json['completedOrders'] ?? 0,
      isVerified: json['isVerified'] ?? false,
    );
  }
}
