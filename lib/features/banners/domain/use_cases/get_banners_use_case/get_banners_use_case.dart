import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/banners/domain/entities/banner_entity.dart';
import 'package:meayar_alitqan/features/banners/domain/repos/get_banners_repo/get_banners_repo.dart';
@injectable
class GetBannersUseCase {
  final GetBannersRepo getBannersRepo;

  GetBannersUseCase({required this.getBannersRepo});
  
  Future<Either<Failures, List<BannerEntity>>> call()  {
    return getBannersRepo.getBanners();
  }
  
}