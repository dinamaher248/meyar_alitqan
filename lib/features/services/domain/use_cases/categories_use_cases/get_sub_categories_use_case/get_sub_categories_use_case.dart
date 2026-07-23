import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/services/domain/repositories/categories_repos/get_sub_categories_repo/get_sub_categories_repo.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../entities/category_entity/category_entity.dart';
@injectable
 class GetSubCategoriesUseCase {
   final GetSubCategoriesRepo getSubCategoriesRepo;
   GetSubCategoriesUseCase(this.getSubCategoriesRepo);
   Future<Either<Failures, List<CategoryEntity>>> call(String subId) async {
     return await getSubCategoriesRepo.getSubCategories(subId);
   }
 }
