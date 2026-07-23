import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/api/api_end_points.dart';
import 'package:meayar_alitqan/core/api/api_manager.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/core/helper/app_messages.dart';
import 'package:meayar_alitqan/core/helper/network_validation.dart';
import 'package:meayar_alitqan/features/reviews/data/data_source/remote/has_review_remote_data_source/has_review_remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@Injectable(as: HasReviewRemoteDataSource)
class HasReviewRemoteDataSourceImpl
    implements HasReviewRemoteDataSource {
  final ApiManager _apiManager = ApiManager();

  @override
  Future<Either<Failures, bool>> hasReview({
    required String orderId,
  }) async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      final session = Supabase.instance.client.auth.currentSession;
      final accessToken = session?.accessToken;

      if (accessToken == null) {
        return Left(ServerFailure("User not authenticated"));
      }

      final response = await _apiManager.post(
        url: ApiEndPoints.hasReview,
        token: accessToken,
        body: {
          "order_id": orderId,
        },
      );

      final bool hasReview = response.data['has_review'] == true;

      return Right(hasReview);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
