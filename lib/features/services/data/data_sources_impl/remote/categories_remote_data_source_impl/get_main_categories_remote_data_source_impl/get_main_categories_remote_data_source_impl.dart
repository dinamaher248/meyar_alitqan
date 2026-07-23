import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../core/api/api_end_points.dart';
import '../../../../../../../core/api/api_manager.dart';
import '../../../../../../../core/errors/failures.dart';
import '../../../../../../../core/helper/app_messages.dart';
import '../../../../../../../core/helper/network_validation.dart';
import '../../../../../domain/entities/category_entity/category_entity.dart';
import '../../../../data_sources/remote/categories_remote_data_source/get_main_categories_remote_data_source/get_main_categories_remote_data_source.dart';
import '../../../../models/category_model/category_model.dart';

@Injectable(as: GetMainCategoriesRemoteDataSource)
class GetMainCategoriesRemoteDataSourceImpl
    implements GetMainCategoriesRemoteDataSource {
  final ApiManager apiManager = ApiManager();

  @override
  Future<Either<Failures, List<CategoryEntity>>> getMainCategories() async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }


      final session =
          Supabase.instance.client.auth.currentSession;
      final accessToken = session?.accessToken;

      final response = await apiManager.post(
        url: ApiEndPoints.getAllServices, // ✅ صح
        body: {
          "mode": "main",
        },
        token: accessToken,
      );

      final List data = response.data['data'] as List;

      final categories = data
          .map((e) => CategoryModel.fromJson(e))
          .toList();

      return Right(categories);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
