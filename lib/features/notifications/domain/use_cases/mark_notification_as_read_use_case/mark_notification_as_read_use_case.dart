import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../repositories/mark_notification_as_read_repo/mark_notification_as_read_repo.dart';
@injectable
 class MarkNotificationAsReadUseCase {
   final MarkNotificationAsReadRepo markNotificationAsReadRepo;
   MarkNotificationAsReadUseCase(this.markNotificationAsReadRepo);
   Future<Either<Failures, void>> call() async {
     return await markNotificationAsReadRepo.markAllNotificationsAsRead();
   }
 }