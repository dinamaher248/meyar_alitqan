import 'package:either_dart/either.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';

abstract class HasReviewRemoteDataSource {
  Future<Either<Failures, bool>> hasReview({required String orderId});
}