import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/repositories/send_notifications_repo/send_notifications_repo.dart';
import '../../data_sources/remote/send_notifications_remote_data_source/send_notifications_remote_data_source.dart';
@Injectable(as: SendNotificationsRepo)
 class SendNotificationsRepoImpl implements SendNotificationsRepo {
   final SendNotificationsRemoteDataSource remoteDataSource;

   SendNotificationsRepoImpl(this.remoteDataSource);

   @override
   Future<Either<Failures, void>> sendNotification({
     String? userId,
     String? userRole,
     required String title,
     required String body,
   }) async {
     return await remoteDataSource.sendNotification(
       userId: userId,
       userRole: userRole,
       title: title,
       body: body,
     );
   }
 }