import '../../../domain/entities/auth/auth_user_entity/auth_user_entity.dart';

abstract class RegisterViewModelStates {}

class RegisterViewModelStatesInitial extends RegisterViewModelStates {}

class RegisterViewModelStatesLoading extends RegisterViewModelStates {}

/// register
class RegisterViewModelStatesSuccess extends RegisterViewModelStates {
  final AuthUserEntity authEntity;

  RegisterViewModelStatesSuccess({required this.authEntity});
}

/// complete register
class CompleteRegisterSuccess extends RegisterViewModelStates {
  final AuthUserEntity authEntity;

  CompleteRegisterSuccess({required this.authEntity});
}

/// send otp
class SendOtpSuccess extends RegisterViewModelStates {}

class RegisterViewModelStatesError extends RegisterViewModelStates {
  final String message;

  RegisterViewModelStatesError({required this.message});
}