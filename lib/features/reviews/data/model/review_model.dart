import 'package:meayar_alitqan/features/reviews/domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
    ReviewModel({
    required super.fromUserId,
    required super.toUserId,
    required super.rating,
    super.comment, required super.orderId, required super.fromRole, required super.toRole,
    
  
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      orderId: json['order_id'] as String,
      fromRole: json['from_role'] as String,
      toRole: json['to_role'] as String,

      fromUserId: json['from_user_id'] as String,
      toUserId: json['to_user_id'] as String,
      rating: json['rating'] as int,
      comment: json['comment'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "from_user_id": fromUserId,
      "to_user_id": toUserId,
      "rating": rating,
      "comment": comment,

    };
  }
}
