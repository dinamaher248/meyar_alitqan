import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/category_entity/category_entity.dart';
import '../../../../domain/repositories/categories_repos/get_main_categories_repo/get_main_categories_repo.dart';
import '../../../data_sources/remote/categories_remote_data_source/get_main_categories_remote_data_source/get_main_categories_remote_data_source.dart';

@Injectable(as: GetMainCategoriesRepo)
class GetMainCategoriesRepoImpl implements GetMainCategoriesRepo {
  final GetMainCategoriesRemoteDataSource getMainCategoriesRemoteDataSource;

  GetMainCategoriesRepoImpl(this.getMainCategoriesRemoteDataSource);

  @override
  Future<Either<Failures, List<CategoryEntity>>> getMainCategories() {
    return getMainCategoriesRemoteDataSource.getMainCategories();
  }
}
