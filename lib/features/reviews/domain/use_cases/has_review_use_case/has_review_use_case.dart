import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/reviews/domain/repos/has_review_repo/has_review_repo.dart';
@injectable
class HasReviewUseCase {
  final HasReviewRepo hasReviewRepo;

  HasReviewUseCase(this.hasReviewRepo);

  Future<Either<Failures, bool>> call({required String orderId}) async =>
      await hasReviewRepo.hasReview(orderId: orderId);
}
