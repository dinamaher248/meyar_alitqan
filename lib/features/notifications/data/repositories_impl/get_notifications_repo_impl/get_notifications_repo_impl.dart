import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/notification_entity.dart';
import '../../../domain/repositories/get_notifications_repo/get_notifications_repo.dart';
import '../../data_sources/remote/get_notifications_remote_data_source/get_notifications_remote_data_source.dart';
@Injectable(as: GetNotificationsRepo)
 class GetNotificationsRepoImpl implements GetNotificationsRepo {
   final GetNotificationsRemoteDataSource remoteDataSource;

   GetNotificationsRepoImpl(this.remoteDataSource);

   @override
   Future<Either<Failures, List<NotificationEntity>>> getNotifications() async {
   return await remoteDataSource.getNotifications();
   }
 }