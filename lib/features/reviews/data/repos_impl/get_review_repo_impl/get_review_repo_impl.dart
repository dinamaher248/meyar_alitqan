import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/reviews/domain/entities/review_entity.dart';
import 'package:meayar_alitqan/features/reviews/domain/repos/get_review_repo/get_review_repo.dart';

import '../../data_source/remote/get_review_remote_data_source/get_review_remote_data_source.dart';
@Injectable(as:GetReviewsRepo )
class GetReviewRepoImpl implements GetReviewsRepo{
  final GetReviewRemoteDataSource getReviewRemoteDataSource;
  GetReviewRepoImpl(this.getReviewRemoteDataSource);
  @override
  Future<Either<Failures, List<ReviewEntity>>> getUserReview({required String userId}) {
    return getReviewRemoteDataSource.getUserReview(userId: userId);
  }

}