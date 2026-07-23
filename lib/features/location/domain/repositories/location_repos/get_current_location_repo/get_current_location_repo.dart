import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../entities/user_location_entity/user_location_entity.dart';

abstract class GetCurrentLocationRepo {
  Future<Either<Failures, UserLocationEntity>> getCurrentLocation();
}