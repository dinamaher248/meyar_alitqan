import 'package:either_dart/either.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/reviews/domain/entities/review_entity.dart';

abstract class AddReviewRemoteDataSource {
  Future<Either<Failures, void>> addReview(ReviewEntity review);
}