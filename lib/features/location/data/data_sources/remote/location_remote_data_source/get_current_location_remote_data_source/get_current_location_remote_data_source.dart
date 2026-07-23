  import 'package:either_dart/either.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../domain/entities/user_location_entity/user_location_entity.dart';

abstract class GetCurrentLocationRemoteDataSource {
    Future<Either<Failures, UserLocationEntity>> getCurrentLocation();
  }