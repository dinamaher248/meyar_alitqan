class CategoryEntity {
  final String id;
  final String name;
  final String? description;
  final String? icon;
  final String? parentId;
  final double? basePrice;
  final int? warrantyDays;
  final DateTime createdAt;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.description,
    this.icon,
    this.parentId,
    this.basePrice,
    this.warrantyDays,
    required this.createdAt,
  });

  bool get isMain => parentId == null;
}
