import '../../../domain/entities/user_location_entity/user_location_entity.dart';

abstract class GetCurrentUserLocationViewModelStates {}
class GetCurrentUserLocationViewModelInitial extends GetCurrentUserLocationViewModelStates {}
class GetCurrentUserLocationViewModelLoading extends GetCurrentUserLocationViewModelStates {}
class GetCurrentUserLocationViewModelSuccess extends GetCurrentUserLocationViewModelStates {
  final UserLocationEntity userLocationEntity;
  GetCurrentUserLocationViewModelSuccess({required this.userLocationEntity});
}
class GetCurrentUserLocationViewModelError extends GetCurrentUserLocationViewModelStates {
  final String message;
  GetCurrentUserLocationViewModelError({required this.message});
}
class GetCurrentUserLocationViewModelPermissionDenied
    extends GetCurrentUserLocationViewModelStates {
  final String message;
  GetCurrentUserLocationViewModelPermissionDenied(this.message);
}
