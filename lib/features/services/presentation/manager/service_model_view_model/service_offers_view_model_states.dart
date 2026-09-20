import '../../../domain/entities/service_offer_entity.dart';

abstract class GetServiceOffersViewModelStates {}

class GetServiceOffersViewModelInitial extends GetServiceOffersViewModelStates {}

class GetServiceOffersViewModelLoading extends GetServiceOffersViewModelStates {}

class GetServiceOffersViewModelSuccess extends GetServiceOffersViewModelStates {
  final List<ServiceOfferEntity> featuredOffers;
  final List<ServiceOfferEntity> mostRequestedServices;

  GetServiceOffersViewModelSuccess({
    this.featuredOffers = const [],
    this.mostRequestedServices = const [],
  });
}

class GetServiceOffersViewModelError extends GetServiceOffersViewModelStates {
  final String message;

  GetServiceOffersViewModelError(this.message);
}