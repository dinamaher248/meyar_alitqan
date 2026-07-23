import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../domain/repositories/profile_repo/update_customer_profile_repo/update_customer_profile_repo.dart';
import '../../../data_sources/remote/profile_remote_data_sources/update_customer_profile_remote_data_source/update_customer_profile_remote_data_source.dart';
@Injectable(as: UpdateCustomerProfileRepo)
class UpdateCustomerProfileRepoImpl implements UpdateCustomerProfileRepo {
  final UpdateCustomerProfileRemoteDataSource remoteDataSource;

  UpdateCustomerProfileRepoImpl(this.remoteDataSource);

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