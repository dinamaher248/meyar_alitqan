import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/reviews/data/data_source/remote/has_review_remote_data_source/has_review_remote_data_source.dart';
import 'package:meayar_alitqan/features/reviews/domain/repos/has_review_repo/has_review_repo.dart';
@Injectable(as: HasReviewRepo)
class HasReviewRepoImpl implements HasReviewRepo{
  final HasReviewRemoteDataSource _hasReviewRemoteDataSource;
  HasReviewRepoImpl(this._hasReviewRemoteDataSource);
  @override
  Future<Either<Failures, bool>> hasReview({required String orderId}) {
    return _hasReviewRemoteDataSource.hasReview(orderId: orderId);
  }
}