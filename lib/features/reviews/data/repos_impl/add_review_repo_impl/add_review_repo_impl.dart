import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/reviews/data/data_source/remote/add_review_remote_data_source/add_review_remote_data_source.dart';
import 'package:meayar_alitqan/features/reviews/domain/entities/review_entity.dart';
import 'package:meayar_alitqan/features/reviews/domain/repos/add_review_repo/add_review_repo.dart';
@Injectable(as:AddReviewRepo )
class AddReviewRepoImpl implements AddReviewRepo{
  final AddReviewRemoteDataSource addReviewRemoteDataSource ; 

  AddReviewRepoImpl(this.addReviewRemoteDataSource);
  @override
  Future<Either<Failures, void>> addReview(ReviewEntity review) {
 return addReviewRemoteDataSource.addReview(review);
  }
}