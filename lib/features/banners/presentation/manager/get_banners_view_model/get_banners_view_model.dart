import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/banners/domain/entities/banner_entity.dart';
import 'package:meayar_alitqan/features/banners/domain/use_cases/get_banners_use_case/get_banners_use_case.dart';
import 'package:meayar_alitqan/features/banners/presentation/manager/get_banners_view_model/get_banners_view_model_states.dart';
@injectable
class GetBannersViewModel extends Cubit<GetBannersViewModelStates> {
  final GetBannersUseCase getBannersUseCase;

  GetBannersViewModel(this.getBannersUseCase)
      : super(GetBannersViewModelInitial());

  List<BannerEntity>? _cachedBanners;

  Future<void> getBanners({bool forceRefresh = false}) async {
    // ✅ لو في كاش
    if (_cachedBanners != null && !forceRefresh) {
      emit(GetBannersViewModelSuccess(_cachedBanners!));
      return;
    }

    emit(GetBannersViewModelLoading());

    final result = await getBannersUseCase.call();

    result.fold(
      (failure) {
        emit(GetBannersViewModelError(failure.message));
      },
      (banners) {
        _cachedBanners = banners;
        emit(GetBannersViewModelSuccess(banners));
      },
    );
  }

  void clearCache() {
    _cachedBanners = null;
  }
}
