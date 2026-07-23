import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../repositories/unread_notifications_count_repo/unread_notifications_count_repo.dart';
@injectable
 class UnreadNotificationsCountUseCase {
   final UnreadNotificationsCountRepo unreadNotificationsCountRepo;
   UnreadNotificationsCountUseCase(this.unreadNotificationsCountRepo);
   Future<Either<Failures, int>> call() async {
     return await unreadNotificationsCountRepo.getUnreadNotificationsCount();
   }
 }