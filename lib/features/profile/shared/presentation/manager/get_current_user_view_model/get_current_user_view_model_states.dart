import '../../../domain/entities/base_profile_entity/base_profile_entity.dart';

abstract class GetCurrentUserViewModelStates {}
class GetCurrentUserViewModelInitial extends GetCurrentUserViewModelStates {}
class GetCurrentUserViewModelLoading extends GetCurrentUserViewModelStates {}
class GetCurrentUserViewModelSuccess extends GetCurrentUserViewModelStates {
  final BaseProfileEntity baseProfileEntity;
  GetCurrentUserViewModelSuccess({required this.baseProfileEntity});
}
class GetCurrentUserViewModelError extends GetCurrentUserViewModelStates {
  final String message;
  GetCurrentUserViewModelError({required this.message});
}
