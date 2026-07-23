import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/reviews/domain/use_cases/has_review_use_case/has_review_use_case.dart';
import 'package:meayar_alitqan/features/reviews/presentation/manager/has_review_view_model/has_review_view_model_states.dart';
@injectable
class HasReviewViewModel extends Cubit<HasReviewViewModelStates> {
  final HasReviewUseCase hasReviewUseCase;

  HasReviewViewModel({required this.hasReviewUseCase})
    : super(HasReviewInitial());

  Future<void> hasReview({required String orderId}) async {
    emit(HasReviewLoading());
    Either<Failures, bool> eitherHasReview = await hasReviewUseCase.call(orderId: orderId);

    eitherHasReview.fold(
      (failure) => emit(HasReviewError ( error:  failure.message)),
      (hasReview) => emit(HasReviewSuccess( hasReview:  hasReview)),
    );
  }
}
