import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/repositories/unread_notifications_count_repo/unread_notifications_count_repo.dart';
import '../../data_sources/remote/unread_notifications_count_remote_data_source/unread_notifications_count_remote_data_source.dart';
@Injectable(as: UnreadNotificationsCountRepo)
 class UnreadNotificationsCountRepoImpl implements UnreadNotificationsCountRepo {
   final UnreadNotificationsCountRemoteDataSource remoteDataSource;

   UnreadNotificationsCountRepoImpl(this.remoteDataSource);

   @override
   Future<Either<Failures, int>> getUnreadNotificationsCount() async {
     return await remoteDataSource.getUnreadNotificationsCount();
   }
 }