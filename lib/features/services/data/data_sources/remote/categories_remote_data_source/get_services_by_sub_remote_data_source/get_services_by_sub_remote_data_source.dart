
 import 'package:either_dart/either.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../domain/entities/category_entity/category_entity.dart';

abstract class GetServicesBySubRemoteDataSource {
  Future<Either<Failures, List<CategoryEntity>>> getServicesBySub(
    String parentId,
  );
 }