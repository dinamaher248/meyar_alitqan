import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/api/api_end_points.dart';
import 'package:meayar_alitqan/core/api/api_manager.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/core/helper/app_messages.dart';
import 'package:meayar_alitqan/core/helper/network_validation.dart';
import 'package:meayar_alitqan/features/reviews/data/data_source/remote/add_review_remote_data_source/add_review_remote_data_source.dart';
import 'package:meayar_alitqan/features/reviews/data/model/add_review_payload.dart';
import 'package:meayar_alitqan/features/reviews/domain/entities/review_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@Injectable(as: AddReviewRemoteDataSource)
class AddReviewRemoteDataSourceImpl
    implements AddReviewRemoteDataSource {

  final ApiManager _apiManager = ApiManager();

  @override
  Future<Either<Failures, void>> addReview(ReviewEntity review) async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      final session = Supabase.instance.client.auth.currentSession;
      if (session == null) {
        return Left(ServerFailure("User not authenticated"));
      }

  final payload = AddReviewPayload(
  orderId: review.orderId,          // 🔥
  fromUserId: review.fromUserId,    // 🔥
  toUserId: review.toUserId,
  fromRole: review.fromRole,        // customer | technician
  toRole: review.toRole,            // technician | customer
  rating: review.rating,
  comment: review.comment,
);

      final response = await _apiManager.post(
        url: ApiEndPoints.addReview,
        token: session.accessToken,
        body: payload.toJson(),
      );

      /// 👇 تحقق من النتيجة
      if (response.statusCode == 200 &&
          response.data["success"] == true) {
        return const Right(null);
      } else {
        return Left(
          ServerFailure(response.data["error"] ?? "حدث خطأ"),
        );
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

