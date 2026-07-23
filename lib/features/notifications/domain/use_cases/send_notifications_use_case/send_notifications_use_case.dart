import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../repositories/send_notifications_repo/send_notifications_repo.dart';
@injectable
class SendNotificationsUseCase {
   final SendNotificationsRepo sendNotificationsRepo;
   SendNotificationsUseCase(this.sendNotificationsRepo);
   Future<Either<Failures, void>> call({
    String? userId,
    String? userRole,
    required String title,
    required String body,
  }) async {
    return await sendNotificationsRepo.sendNotification(
      userId: userId,
      userRole: userRole,
      title: title,
      body: body,
    );
  }
}