import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/profile/techinican/domain/repositories/profile_repo/update_technician_profile_repo/update_technician_profile_repo.dart';

import '../../../../../../../core/errors/failures.dart';
@injectable
class UpdateTechnicianProfileUseCase {
  final UpdateTechnicianProfileRepo repo;

  UpdateTechnicianProfileUseCase(this.repo);

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