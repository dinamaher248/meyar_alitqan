class BannerEntity {
  final String id;
  final String title;
  final String imageUrl;
  final String? linkUrl;
  final bool isActive;
  final int position;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BannerEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.isActive,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
    this.linkUrl,
    this.startDate,
    this.endDate,
  });
}
