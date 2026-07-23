import '../../../domain/entities/upload_result_entity/upload_result_entity.dart';

class UploadResultModel extends UploadResultEntity {
  const UploadResultModel({
    required super.path,
    super.publicUrl,
    required super.type,
  });

  factory UploadResultModel.fromJson(Map<String, dynamic> json) {
    return UploadResultModel(
      path: json['path'],
      publicUrl: json['public_url'],
      type: json['type'],
    );
  }
}
