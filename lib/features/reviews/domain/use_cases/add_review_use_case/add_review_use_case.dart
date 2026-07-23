import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/reviews/domain/entities/review_entity.dart';
import 'package:meayar_alitqan/features/reviews/domain/repos/add_review_repo/add_review_repo.dart';
@injectable
class AddReviewUseCase {
  final AddReviewRepo addReviewRepo;
  AddReviewUseCase(this.addReviewRepo);
  Future<Either<Failures, void>> call({
    required ReviewEntity reviewEntity,
  }) async => await addReviewRepo.addReview(reviewEntity);
}
