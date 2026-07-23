import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../entities/category_entity/category_entity.dart';
import '../../../repositories/categories_repos/get_main_categories_repo/get_main_categories_repo.dart';
@injectable
 class GetMainCategoriesUseCase {
   final GetMainCategoriesRepo getMainCategoriesRepo;
   GetMainCategoriesUseCase(this.getMainCategoriesRepo);
   
   Future<Either<Failures, List<CategoryEntity>>> call() async {
     return await getMainCategoriesRepo.getMainCategories();
   }

 }