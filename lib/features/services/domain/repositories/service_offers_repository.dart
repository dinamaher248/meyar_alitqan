// lib/features/services/domain/repositories/service_offers_repository.dart

import '../entities/service_offer_entity.dart';

abstract class ServiceOffersRepository {
  Future<List<ServiceOfferEntity>> getFeaturedOffers();
  Future<List<ServiceOfferEntity>> getMostRequestedServices();
}