import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../entities/category_entity/category_entity.dart';

abstract class GetSubCategoriesRepo {
  Future<Either<Failures, List<CategoryEntity>>> getSubCategories(String subId);
}
