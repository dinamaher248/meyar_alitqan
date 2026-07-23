import 'package:either_dart/either.dart';

import '../../../../../../../../core/errors/failures.dart';

abstract class UpdateTechnicianProfileRemoteDataSource {
  Future<Either<Failures, void>> updateProfile({
    String? name,
    String? phone,
    String? avatar,
    String? address,
  });
}