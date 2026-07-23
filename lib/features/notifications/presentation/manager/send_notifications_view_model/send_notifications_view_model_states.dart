abstract class SendNotificationsViewModelStates {}

class SendNotificationsViewModelInitial extends SendNotificationsViewModelStates {}
class SendNotificationsViewModelLoading extends SendNotificationsViewModelStates {}
class SendNotificationsViewModelSuccess extends SendNotificationsViewModelStates {}
class SendNotificationsViewModelError extends SendNotificationsViewModelStates {
  final String message;

  SendNotificationsViewModelError(this.message);
}
