import '../../../../../core/errors/failures.dart';

abstract class DeleteNotificationDataViewModelStates {}
class DeleteNotificationDataViewModelInitial extends DeleteNotificationDataViewModelStates {}
class DeleteNotificationDataViewModelLoading extends DeleteNotificationDataViewModelStates {}
class DeleteNotificationDataViewModelSuccess extends DeleteNotificationDataViewModelStates {}
class DeleteNotificationDataViewModelError extends DeleteNotificationDataViewModelStates {
  final Failures failure;
  DeleteNotificationDataViewModelError({required this.failure});
}
