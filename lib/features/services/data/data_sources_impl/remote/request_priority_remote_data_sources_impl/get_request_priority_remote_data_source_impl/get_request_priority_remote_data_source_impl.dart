import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/api/api_end_points.dart';
import 'package:meayar_alitqan/core/api/api_manager.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/core/helper/app_messages.dart';
import 'package:meayar_alitqan/core/helper/network_validation.dart';
import 'package:meayar_alitqan/features/services/data/data_sources/remote/request_priority_remote_data_sources/get_request_priority_remote_data_source/get_request_priority_remote_data_source.dart';
import 'package:meayar_alitqan/features/services/data/models/request_priority_model/request_priority_model.dart';
import 'package:meayar_alitqan/features/services/domain/entities/request_priority_entity/request_priority_entity.dart';

@Injectable(as: GetRequestPriorityRemoteDataSource)
class GetRequestPriorityRemoteDataSourceImpl
    implements GetRequestPriorityRemoteDataSource {

  final ApiManager _apiManager = ApiManager();

  @override
  Future<Either<Failures, List<RequestPriorityEntity>>> getRequestPriority() async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      final response = await _apiManager.get(
        url: ApiEndPoints.getRequestPriorities,
      );

      // ✅ Edge Function بترجع List مباشرة
      final List data = response.data as List;

      final priorities = data
          .map((e) => RequestPriorityModel.fromJson(e))
          .toList();

      return Right(priorities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
