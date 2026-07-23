import 'package:either_dart/either.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/location/domain/entities/service_areas_entity/service_areas_entity.dart';

abstract class GetServiceAreasRemoteDataSource {
  Future<Either<Failures, List<ServiceAreaEntity>>> getServiceAreas();
}