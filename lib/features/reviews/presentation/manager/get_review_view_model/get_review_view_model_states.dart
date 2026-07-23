import 'package:meayar_alitqan/features/reviews/domain/entities/review_entity.dart';

abstract class GetReviewViewModelStates {}

class GetReviewViewModelInitial extends GetReviewViewModelStates {}

class GetReviewViewModelLoading extends GetReviewViewModelStates {}

class GetReviewViewModelSuccess extends GetReviewViewModelStates {
  final List<ReviewEntity> reviews;
  GetReviewViewModelSuccess(this.reviews);
}

class GetReviewViewModelError extends GetReviewViewModelStates {
  final String message;
  GetReviewViewModelError(this.message);
}