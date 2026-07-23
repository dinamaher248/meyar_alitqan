
import 'package:meayar_alitqan/features/location/domain/entities/service_areas_entity/service_areas_entity.dart';

class ServiceAreaModel extends ServiceAreaEntity {
  const ServiceAreaModel({
    required super.id,
    required super.name,
  });

  factory ServiceAreaModel.fromJson(Map<String, dynamic> json) {
    return ServiceAreaModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
