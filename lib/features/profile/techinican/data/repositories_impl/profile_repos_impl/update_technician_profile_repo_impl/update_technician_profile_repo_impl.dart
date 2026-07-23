import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../domain/repositories/profile_repo/update_technician_profile_repo/update_technician_profile_repo.dart';
import '../../../data_sources/remote/profile_remote_data_sources/update_technician_profile_remote_data_source/update_technician_profile_remote_data_source.dart';
@Injectable(as: UpdateTechnicianProfileRepo)
class UpdateTechnicianProfileRepoImpl implements UpdateTechnicianProfileRepo {
  final UpdateTechnicianProfileRemoteDataSource remoteDataSource;

  UpdateTechnicianProfileRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failures, void>> updateProfile({
   String? name,
   String? phone,
   String? avatar,
   String? address,
  }) {
    return remoteDataSource.updateProfile(
   name: name,
   phone: phone,
   avatar: avatar,
   address: address,
    );
  }
}