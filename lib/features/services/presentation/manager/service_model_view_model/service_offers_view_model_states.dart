// get_service_offers_view_model_states.dart

import '../../../domain/entities/service_offer_entity.dart';

abstract class GetServiceOffersViewModelStates {}

class GetServiceOffersViewModelInitial extends GetServiceOffersViewModelStates {}

class GetServiceOffersViewModelLoading extends GetServiceOffersViewModelStates {}

class GetServiceOffersViewModelSuccess extends GetServiceOffersViewModelStates {
  final List<ServiceOfferEntity> offers;
  GetServiceOffersViewModelSuccess(this.offers);
}

class GetServiceOffersViewModelError extends GetServiceOffersViewModelStates {
  final String message;
  GetServiceOffersViewModelError(this.message);
}