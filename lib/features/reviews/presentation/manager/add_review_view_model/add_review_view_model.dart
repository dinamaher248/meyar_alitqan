import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/reviews/domain/entities/review_entity.dart';
import 'package:meayar_alitqan/features/reviews/domain/use_cases/add_review_use_case/add_review_use_case.dart';
import 'package:meayar_alitqan/features/reviews/presentation/manager/add_review_view_model/add_review_view_model_states.dart';

@injectable
class AddReviewViewModel extends Cubit<AddReviewViewModelStates> {
  final AddReviewUseCase addReviewUseCase;

  AddReviewViewModel({required this.addReviewUseCase})
    : super(AddReviewInitial());

  Future<void> addReview({required ReviewEntity reviewEntity}) async {
    emit(AddReviewLoading());
    final either = await addReviewUseCase.call(reviewEntity: reviewEntity);
    either.fold(
      (failure) {
        emit(AddReviewError(failure.message));
      },
      (r) {
        emit(AddReviewSuccess());
      },
    );
  }
}
