import 'package:either_dart/either.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/banners/domain/entities/banner_entity.dart';

abstract class  GetBannersRemoteDataSource {
  Future<Either<Failures, List<BannerEntity>>> getBanners();
}