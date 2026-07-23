import '../../../../profile/shared/domain/entities/base_profile_entity/base_profile_entity.dart';

abstract class GoogleAuthViewModelStates {}
class GoogleAuthViewModelInitial extends GoogleAuthViewModelStates {}
class GoogleAuthViewModelLoading extends GoogleAuthViewModelStates {}
class GoogleAuthViewModelSuccess extends GoogleAuthViewModelStates {
  final BaseProfileEntity  user;
  GoogleAuthViewModelSuccess(this.user);
}
class GoogleAuthViewModelError extends GoogleAuthViewModelStates {
  final String message;
  GoogleAuthViewModelError(this.message);
}