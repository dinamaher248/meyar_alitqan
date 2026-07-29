// get_service_offers_view_model.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/repositories/service_offers_repository.dart';
import 'service_offers_view_model_states.dart';

@injectable
class GetServiceOffersViewModel extends Cubit<GetServiceOffersViewModelStates> {
  final ServiceOffersRepository repository;

  GetServiceOffersViewModel(this.repository)
    : super(GetServiceOffersViewModelInitial());

  Future<void> getFeaturedOffers() async {
    emit(GetServiceOffersViewModelLoading());
    try {
      final offers = await repository.getFeaturedOffers();
      emit(GetServiceOffersViewModelSuccess(offers));
    } catch (e) {
      emit(GetServiceOffersViewModelError(e.toString()));
    }
  }

  Future<void> getMostRequestedServices() async {
    emit(GetServiceOffersViewModelLoading());
    try {
      final offers = await repository.getMostRequestedServices();
      emit(GetServiceOffersViewModelSuccess(offers));
    } catch (e) {
      emit(GetServiceOffersViewModelError(e.toString()));
    }
  }
}
