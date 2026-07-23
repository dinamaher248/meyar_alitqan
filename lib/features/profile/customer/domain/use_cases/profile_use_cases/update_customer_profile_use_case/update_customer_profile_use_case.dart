import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../repositories/profile_repo/update_customer_profile_repo/update_customer_profile_repo.dart';
@injectable
class UpdateCustomerProfileUseCase {
  final UpdateCustomerProfileRepo repo;

  UpdateCustomerProfileUseCase(this.repo);

  Future<Either<Failures, void>> call({
   String? name,
   String? phone,
   String? avatar,
   String? address,
  }) {
    return repo.updateProfile(
     name: name,
     phone: phone,
     avatar: avatar,
     address: address,
    );
  }
}