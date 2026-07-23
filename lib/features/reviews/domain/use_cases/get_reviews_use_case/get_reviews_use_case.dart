import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/reviews/domain/entities/review_entity.dart';
import 'package:meayar_alitqan/features/reviews/domain/repos/get_review_repo/get_review_repo.dart';
@injectable
class GetReviewsUseCase {
  final GetReviewsRepo getReviewsRepo;
  GetReviewsUseCase(this.getReviewsRepo);
  Future<Either<Failures, List<ReviewEntity>>> call({
    required String userId,
  }) async => await getReviewsRepo.getUserReview(userId: userId);
}
