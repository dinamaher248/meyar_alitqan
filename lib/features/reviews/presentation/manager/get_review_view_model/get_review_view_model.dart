import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/reviews/domain/use_cases/get_reviews_use_case/get_reviews_use_case.dart';
import 'package:meayar_alitqan/features/reviews/presentation/manager/get_review_view_model/get_review_view_model_states.dart';
@injectable
class GetReviewViewModel extends Cubit<GetReviewViewModelStates> {
  final GetReviewsUseCase getReviewsUseCase;
  GetReviewViewModel(this.getReviewsUseCase)
    : super(GetReviewViewModelInitial());

  Future<void> getReviews(String userId) async {
    emit(GetReviewViewModelLoading());
    final result = await getReviewsUseCase(userId: userId);
    result.fold(
      (l) => emit(GetReviewViewModelError(l.message)),
      (r) => emit(GetReviewViewModelSuccess(r)),
    );
  }
}
