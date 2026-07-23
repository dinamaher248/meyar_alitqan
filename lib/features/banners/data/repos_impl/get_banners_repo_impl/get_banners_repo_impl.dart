import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/banners/data/data_source/remote/get_banners_remote_data_source/get_banners_remote_data_source.dart';
import 'package:meayar_alitqan/features/banners/domain/entities/banner_entity.dart';
import 'package:meayar_alitqan/features/banners/domain/repos/get_banners_repo/get_banners_repo.dart';

@Injectable(as: GetBannersRepo)
class GetBannersRepoImpl implements GetBannersRepo {
  final GetBannersRemoteDataSource getBannersRemoteDataSource;
  GetBannersRepoImpl(this.getBannersRemoteDataSource);
  @override
  Future<Either<Failures, List<BannerEntity>>> getBanners() {
    return getBannersRemoteDataSource.getBanners();
  }
}
