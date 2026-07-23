import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/api/api_end_points.dart';
import 'package:meayar_alitqan/core/api/api_manager.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/core/helper/app_messages.dart';
import 'package:meayar_alitqan/core/helper/network_validation.dart';
import 'package:meayar_alitqan/features/reviews/data/model/review_model.dart';
import 'package:meayar_alitqan/features/reviews/domain/entities/review_entity.dart';

import '../../../data_source/remote/get_review_remote_data_source/get_review_remote_data_source.dart';


@Injectable(as: GetReviewRemoteDataSource)
class GetReviewRemoteDataSourceImpl
    implements GetReviewRemoteDataSource {

  final ApiManager _apiManager = ApiManager();

  @override
  Future<Either<Failures, List<ReviewEntity>>> getUserReview({
    required String userId,
  }) async {
    try {
      // 🌐 Check internet
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      // 🚀 Call edge function
      final response = await _apiManager.get(
        url: ApiEndPoints.getReviews,
        query: {
          "user_id": userId,
        },
      );

      final List data = response.data as List;

      final reviews = data
          .map((e) => ReviewModel.fromJson(e))
          .toList();

      return Right(reviews);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
