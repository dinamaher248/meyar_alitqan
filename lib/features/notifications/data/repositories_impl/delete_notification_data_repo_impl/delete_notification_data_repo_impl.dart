import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/repositories/delete_notification_data_repo/delete_notification_data_repo.dart';
import '../../data_sources/remote/delete_notification_data_remote_data_source/delete_notification_data_remote_data_source.dart';

@Injectable(
  as: DeleteNotificationDataRepo,
)
class DeleteNotificationDataRepoImpl implements DeleteNotificationDataRepo {
  final DeleteNotificationDataRemoteDataSource remoteDataSource;

  DeleteNotificationDataRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, void>> deleteNotificationData(String notificationId) {
    return remoteDataSource.deleteNotificationData(notificationId);

  }


}