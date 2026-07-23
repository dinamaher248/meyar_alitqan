class ReviewEntity {
  final String orderId;
  final String fromUserId;
  final String toUserId;
  final String fromRole;
  final String toRole;
  final int rating;
  final String? comment;

  ReviewEntity({
    required this.orderId,
    required this.fromUserId,
    required this.toUserId,
    required this.fromRole,
    required this.toRole,
    required this.rating,
    this.comment,
  });
}
