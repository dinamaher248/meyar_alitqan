import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../repositories/delete_notification_data_repo/delete_notification_data_repo.dart';
@injectable
 class DeleteNotificationDataUseCase {
   final DeleteNotificationDataRepo deleteNotificationDataRepo;
   DeleteNotificationDataUseCase({required this.deleteNotificationDataRepo});
   Future<Either<Failures, void>> deleteNotificationData(String notificationId) {
    return deleteNotificationDataRepo.deleteNotificationData(notificationId);
   }
 }