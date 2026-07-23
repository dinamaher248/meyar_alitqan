abstract class UnreadNotificationsCountViewModelStates {}

class UnreadNotificationsCountViewModelInitial extends UnreadNotificationsCountViewModelStates {}
class UnreadNotificationsCountViewModelLoading extends UnreadNotificationsCountViewModelStates {}
class UnreadNotificationsCountViewModelSuccess extends UnreadNotificationsCountViewModelStates {
  final int unreadNotificationsCount;

  UnreadNotificationsCountViewModelSuccess(this.unreadNotificationsCount);
}
class UnreadNotificationsCountViewModelError extends UnreadNotificationsCountViewModelStates {
  final String message;

  UnreadNotificationsCountViewModelError(this.message);
}
