import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../entities/category_entity/category_entity.dart';

abstract class GetServicesBySubRepo {
  Future<Either<Failures, List<CategoryEntity>>> getServicesBySub(
    String parentId,
  );
}
