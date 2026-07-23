class UploadResultEntity {
  final List<String> path;
  final String type;
  final String? publicUrl;

  const UploadResultEntity({
    required this.path,
    required this.type,
    this.publicUrl,
  });

  UploadResultEntity copyWith({
    List<String>? path,
    String? type,
    String? publicUrl,
  }) {
    return UploadResultEntity(
      path: path ?? this.path,
      type: type ?? this.type,
      publicUrl: publicUrl ?? this.publicUrl,
    );
  }
}
