class AddReviewPayload {
  final String toUserId;
  final int rating;
  final String? comment;

  String? orderId;
  String? fromUserId;
  String? fromRole;
  String? toRole;

  AddReviewPayload({
    required this.toUserId,
    required this.rating,
    this.comment,
    this.orderId,
    this.fromUserId,
    this.fromRole,
    this.toRole,
  });

Map<String, dynamic> toJson() {
  return {
    "order_id": orderId,
    "from_user_id": fromUserId,
    "to_user_id": toUserId,
    "from_role": fromRole,  
    "to_role": toRole,      
    "rating": rating,
    "comment": comment,
  };
}

}
