import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/api/api_end_points.dart';
import 'package:meayar_alitqan/core/api/api_manager.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/core/helper/app_messages.dart';
import 'package:meayar_alitqan/core/helper/network_validation.dart';
import 'package:meayar_alitqan/features/banners/data/data_source/remote/get_banners_remote_data_source/get_banners_remote_data_source.dart';
import 'package:meayar_alitqan/features/banners/data/model/banner_model.dart';
import 'package:meayar_alitqan/features/banners/domain/entities/banner_entity.dart';

@Injectable(as: GetBannersRemoteDataSource)
class GetBannersRemoteDataSourceImpl implements GetBannersRemoteDataSource {
  final ApiManager _apiManager = ApiManager();

  @override
  Future<Either<Failures, List<BannerEntity>>> getBanners() async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      final response = await _apiManager.get(url: ApiEndPoints.getBanners);

      final List data = response.data as List;

      final banners = data.map((e) => BannerModel.fromJson(e)).toList();

      return Right(banners);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
