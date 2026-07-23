part of 'complete_profile_view_model.dart';

abstract class CompleteProfileStates {}

class CompleteProfileInitial extends CompleteProfileStates {}

class CompleteProfileLoading extends CompleteProfileStates {}

class CompleteProfileSuccess extends CompleteProfileStates {
  final String phone;
  CompleteProfileSuccess(this.phone);
}

class CompleteProfileError extends CompleteProfileStates {
  final String message;
  CompleteProfileError(this.message);
}
