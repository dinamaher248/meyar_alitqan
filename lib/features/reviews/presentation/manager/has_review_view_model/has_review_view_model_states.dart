abstract class HasReviewViewModelStates {}
class HasReviewInitial extends HasReviewViewModelStates {}
class HasReviewLoading extends HasReviewViewModelStates {}
class HasReviewSuccess extends HasReviewViewModelStates {
  final bool hasReview;
  HasReviewSuccess({required this.hasReview});
}
class HasReviewError extends HasReviewViewModelStates {
  final String error;
  HasReviewError({required this.error});
}