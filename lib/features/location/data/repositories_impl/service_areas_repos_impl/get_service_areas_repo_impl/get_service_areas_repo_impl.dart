import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/location/data/data_sources/remote/service_areas_remote_data_source/get_service_areas_remote_data_source/get_service_areas_remote_data_source.dart';
import 'package:meayar_alitqan/features/location/domain/entities/service_areas_entity/service_areas_entity.dart';
import 'package:meayar_alitqan/features/location/domain/repositories/service_areas_repos/get_service_areas_repo/get_service_areas_repo.dart';
@Injectable(as: GetServiceAreasRepo)
class GetServiceAreasRepoImpl implements GetServiceAreasRepo{
  final GetServiceAreasRemoteDataSource getServiceAreasRemoteDataSource;

  GetServiceAreasRepoImpl({required this.getServiceAreasRemoteDataSource});
  @override
  Future<Either<Failures, List<ServiceAreaEntity>>> getServiceAreas() {
 return getServiceAreasRemoteDataSource.getServiceAreas();
  }
}