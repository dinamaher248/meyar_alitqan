import 'package:meayar_alitqan/features/location/domain/entities/service_areas_entity/service_areas_entity.dart';

abstract class GetServiceAreasViewModelStates {}
class GetServiceAreasViewModelInitial extends GetServiceAreasViewModelStates {}
class GetServiceAreasViewModelLoading extends GetServiceAreasViewModelStates {}
class GetServiceAreasViewModelSuccess extends GetServiceAreasViewModelStates {
  final List<ServiceAreaEntity> serviceAreas;
  GetServiceAreasViewModelSuccess(this.serviceAreas);
}
class GetServiceAreasViewModelError extends GetServiceAreasViewModelStates {
  final String message;
  GetServiceAreasViewModelError(this.message);
}