 import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/user_location_entity/user_location_entity.dart';
import '../../../../domain/repositories/location_repos/get_current_location_repo/get_current_location_repo.dart';
import '../../../data_sources/remote/location_remote_data_source/get_current_location_remote_data_source/get_current_location_remote_data_source.dart';
@Injectable(as: GetCurrentLocationRepo)
class GetCurrentLocationRepoImpl implements GetCurrentLocationRepo {
  final GetCurrentLocationRemoteDataSource remoteDataSource;

  GetCurrentLocationRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failures, UserLocationEntity>> getCurrentLocation() {
    return remoteDataSource.getCurrentLocation();
  }
}