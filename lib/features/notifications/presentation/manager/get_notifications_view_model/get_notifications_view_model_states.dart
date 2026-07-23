import '../../../domain/entities/notification_entity.dart';

abstract class GetNotificationsViewModelStates {}
class GetNotificationsViewModelInitial extends GetNotificationsViewModelStates {}
class GetNotificationsViewModelLoading extends GetNotificationsViewModelStates {}
class GetNotificationsViewModelSuccess extends GetNotificationsViewModelStates {
  final List<NotificationEntity> notifications;

  GetNotificationsViewModelSuccess(this.notifications);
}
class GetNotificationsViewModelError extends GetNotificationsViewModelStates {
  final String message;

  GetNotificationsViewModelError(this.message);
}