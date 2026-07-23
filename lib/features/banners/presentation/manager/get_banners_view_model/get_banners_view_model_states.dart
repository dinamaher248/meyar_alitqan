import 'package:meayar_alitqan/features/banners/domain/entities/banner_entity.dart';

abstract class GetBannersViewModelStates {}

class GetBannersViewModelInitial extends GetBannersViewModelStates {}

class GetBannersViewModelLoading extends GetBannersViewModelStates {}

class GetBannersViewModelSuccess extends GetBannersViewModelStates {
  final List<BannerEntity> banners;
  GetBannersViewModelSuccess(this.banners);
}

class GetBannersViewModelError extends GetBannersViewModelStates {
  final String error;
  GetBannersViewModelError(this.error);
}