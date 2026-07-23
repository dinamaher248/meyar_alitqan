
import '../../../../profile/shared/domain/entities/base_profile_entity/base_profile_entity.dart';

abstract class LoginViewModelStates {}
class LoginViewModelInitial extends LoginViewModelStates {}
class LoginViewModelLoading extends LoginViewModelStates {}
class LoginViewModelError extends LoginViewModelStates {
  final String message;

  LoginViewModelError({required this.message});
}
class LoginViewModelSuccess extends LoginViewModelStates {
  final BaseProfileEntity profile;

  LoginViewModelSuccess({required this.profile});
}
