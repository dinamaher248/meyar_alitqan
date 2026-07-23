import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/api/api_end_points.dart';
import 'package:meayar_alitqan/core/api/api_manager.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/core/helper/app_messages.dart';
import 'package:meayar_alitqan/core/helper/network_validation.dart';
import 'package:meayar_alitqan/features/location/data/data_sources/remote/service_areas_remote_data_source/get_service_areas_remote_data_source/get_service_areas_remote_data_source.dart';
import 'package:meayar_alitqan/features/location/data/models/service_area_model/service_area_model.dart';
import 'package:meayar_alitqan/features/location/domain/entities/service_areas_entity/service_areas_entity.dart';

@Injectable(as: GetServiceAreasRemoteDataSource)
class GetServiceAreasRemoteDataSourceImpl
    implements GetServiceAreasRemoteDataSource {

  final ApiManager _apiManager = ApiManager();

  @override
  Future<Either<Failures, List<ServiceAreaEntity>>> getServiceAreas() async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      final response = await _apiManager.get(
        url: ApiEndPoints.getServiceAreas,
      );

      final List data = response.data as List;

      final areas = data
          .map((e) => ServiceAreaModel.fromJson(e))
          .toList();

      return Right(areas);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
