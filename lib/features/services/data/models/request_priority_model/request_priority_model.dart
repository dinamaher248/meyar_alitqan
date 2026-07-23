import 'package:meayar_alitqan/features/services/domain/entities/request_priority_entity/request_priority_entity.dart';

class RequestPriorityModel extends RequestPriorityEntity {
  const RequestPriorityModel({
    required super.type,
    required super.percentage,
  });

  factory RequestPriorityModel.fromJson(Map<String, dynamic> json) {
    return RequestPriorityModel(
      type: json['type'] as String,
      percentage: json['percentage'] as int,
    );
  }
}
