import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/location/domain/entities/service_areas_entity/service_areas_entity.dart';
import 'package:meayar_alitqan/features/location/domain/repositories/service_areas_repos/get_service_areas_repo/get_service_areas_repo.dart';
@injectable
class GetServiceAreasUseCase {
  final GetServiceAreasRepo getServiceAreasRepo;

  GetServiceAreasUseCase({required this.getServiceAreasRepo});

  Future<Either<Failures, List<ServiceAreaEntity>>> call()async{

    return await getServiceAreasRepo.getServiceAreas();

  }
}