import 'package:either_dart/either.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/reviews/domain/entities/review_entity.dart';

abstract class GetReviewsRepo {
  Future<Either<Failures, List<ReviewEntity>>> getUserReview( {required String userId});
}