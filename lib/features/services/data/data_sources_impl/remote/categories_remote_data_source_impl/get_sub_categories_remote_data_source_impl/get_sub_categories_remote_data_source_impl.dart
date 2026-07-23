import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/api/api_end_points.dart';
import '../../../../../../../core/api/api_manager.dart';
import '../../../../../../../core/errors/failures.dart';
import '../../../../../../../core/helper/app_messages.dart';
import '../../../../../../../core/helper/network_validation.dart';
import '../../../../../domain/entities/category_entity/category_entity.dart';
import '../../../../data_sources/remote/categories_remote_data_source/get_sub_categories_remote_data_source/get_sub_categories_remote_data_source.dart';
import '../../../../models/category_model/category_model.dart';
@injectable
class GetSubCategoriesRemoteDataSourceImpl
    implements GetSubCategoriesRemoteDataSource {

  final ApiManager apiManager = ApiManager();

  @override
  Future<Either<Failures, List<CategoryEntity>>> getSubCategories(
      String subId) async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      final response = await apiManager.post(
        url: ApiEndPoints.getAllServices,
        body: {
          "mode": "sub",
          "parent_id": subId,
        },
      );

      if (response.data['success'] != true) {
        return Left(ServerFailure(
          response.data['error'] ?? AppMessages.serverError,
        ));
      }

      final List data = (response.data['data'] as List?) ?? [];

      final subCategories = data
          .map((e) => CategoryModel.fromJson(e))
          .toList();

      return Right(subCategories);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
