abstract class AddReviewViewModelStates {}

class AddReviewInitial extends AddReviewViewModelStates {}

class AddReviewLoading extends AddReviewViewModelStates {}

class AddReviewSuccess extends AddReviewViewModelStates {}

class AddReviewError extends AddReviewViewModelStates {
  final String error;
  AddReviewError(this.error);
}