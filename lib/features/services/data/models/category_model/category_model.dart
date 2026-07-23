import '../../../domain/entities/category_entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    super.description,
    super.icon,
    super.parentId,
    super.basePrice,
    super.warrantyDays,
    required super.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'],
      icon: json['icon'],
      parentId: json['parent_id'],
      basePrice: json['base_price'] != null
          ? (json['base_price'] as num).toDouble()
          : null,
      warrantyDays: json['warranty_days'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'parent_id': parentId,
      'base_price': basePrice,
      'warranty_days': warrantyDays,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
