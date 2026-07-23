import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/category_entity/category_entity.dart';
import '../../../../domain/repositories/categories_repos/get_sub_categories_repo/get_sub_categories_repo.dart';
import '../../../data_sources/remote/categories_remote_data_source/get_sub_categories_remote_data_source/get_sub_categories_remote_data_source.dart';
@Injectable(as: GetSubCategoriesRepo)
class GetSubCategoriesRepoImpl implements GetSubCategoriesRepo {
  final GetSubCategoriesRemoteDataSource getSubCategoriesRemoteDataSource;
  GetSubCategoriesRepoImpl(this.getSubCategoriesRemoteDataSource);

  @override
  Future<Either<Failures, List<CategoryEntity>>> getSubCategories(String subId) {
    return getSubCategoriesRemoteDataSource.getSubCategories(subId);
  }
}