import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/service_offer_entity.dart';
import '../../../domain/repositories/service_offers_repository.dart';
import 'service_offers_view_model_states.dart';

@injectable
class GetServiceOffersViewModel extends Cubit<GetServiceOffersViewModelStates> {
  final ServiceOffersRepository repository;

  GetServiceOffersViewModel(this.repository)
      : super(GetServiceOffersViewModelInitial());

  Future<void> getFeaturedOffers() async {
    // نحتفظ بالبيانات القديمة لـ mostRequestedServices إن كانت موجودة
    final currentMostRequested = state is GetServiceOffersViewModelSuccess
        ? (state as GetServiceOffersViewModelSuccess).mostRequestedServices
        : <ServiceOfferEntity>[];

    // لا نرسل Loading إذا كان لدينا بيانات حتى لا تظهر دائرة التحميل وتختفي البيانات الأخرى
    if (state is! GetServiceOffersViewModelSuccess) {
      emit(GetServiceOffersViewModelLoading());
    }

    try {
      final offers = await repository.getFeaturedOffers();
      emit(GetServiceOffersViewModelSuccess(
        featuredOffers: offers,
        mostRequestedServices: currentMostRequested, // نحتفظ بالبيانات ولا نرسل null
      ));
    } catch (e) {
      emit(GetServiceOffersViewModelError(e.toString()));
    }
  }

  Future<void> getMostRequestedServices() async {
    // نحتفظ بالبيانات القديمة لـ featuredOffers إن كانت موجودة
    final currentFeatured = state is GetServiceOffersViewModelSuccess
        ? (state as GetServiceOffersViewModelSuccess).featuredOffers
        : <ServiceOfferEntity>[];

    if (state is! GetServiceOffersViewModelSuccess) {
      emit(GetServiceOffersViewModelLoading());
    }

    try {
      final offers = await repository.getMostRequestedServices();
      emit(GetServiceOffersViewModelSuccess(
        featuredOffers: currentFeatured, // نحتفظ بالبيانات ولا نرسل null
        mostRequestedServices: offers,
      ));
    } catch (e) {
      emit(GetServiceOffersViewModelError(e.toString()));
    }
  }
}