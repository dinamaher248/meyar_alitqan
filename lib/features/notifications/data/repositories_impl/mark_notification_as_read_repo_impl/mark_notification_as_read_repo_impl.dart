import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/repositories/mark_notification_as_read_repo/mark_notification_as_read_repo.dart';
import '../../data_sources/remote/mark_notification_as_read_remote_data_source/mark_notification_as_read_remote_data_source.dart';
@Injectable(as: MarkNotificationAsReadRepo)
 class MarkNotificationAsReadRepoImpl implements MarkNotificationAsReadRepo {
   final MarkNotificationAsReadRemoteDataSource remoteDataSource;

   MarkNotificationAsReadRepoImpl(this.remoteDataSource);

   @override
   Future<Either<Failures, void>> markAllNotificationsAsRead( ) async {
     return await remoteDataSource.markAllNotificationsAsRead();
   }
 }