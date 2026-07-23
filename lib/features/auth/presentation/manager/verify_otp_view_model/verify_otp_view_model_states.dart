import '../../../../profile/shared/domain/entities/base_profile_entity/base_profile_entity.dart';
import '../../../data/models/auth/auth_user_model/auth_user_model.dart';
import '../../../domain/entities/auth/auth_user_entity/auth_user_entity.dart';

abstract class VerifyOtpStates {}

class VerifyOtpInitial extends VerifyOtpStates {}

class VerifyOtpLoading extends VerifyOtpStates {}
class VerifyOtpSuccess extends VerifyOtpStates {
  final BaseProfileEntity profile;
  VerifyOtpSuccess(this.profile);
}

class VerifyOtpError extends VerifyOtpStates {
  final String message;

  VerifyOtpError(this.message);
}