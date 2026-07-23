import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../entities/user_location_entity/user_location_entity.dart';
import '../../../repositories/location_repos/get_current_location_repo/get_current_location_repo.dart';
@injectable
class GetCurrentLocationUseCase {
  final GetCurrentLocationRepo repo;

  GetCurrentLocationUseCase(this.repo);

  Future<Either<Failures, UserLocationEntity>> call() async {
    return await repo.getCurrentLocation();
  }
}