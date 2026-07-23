import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/notification_entity.dart';
import '../../repositories/get_notifications_repo/get_notifications_repo.dart';
@injectable
 class GetNotificationsUseCase {
   final GetNotificationsRepo getNotificationsRepo;
   GetNotificationsUseCase(this.getNotificationsRepo);
   Future<Either<Failures, List<NotificationEntity>>> call() async {
     return await getNotificationsRepo.getNotifications();
   }
 }