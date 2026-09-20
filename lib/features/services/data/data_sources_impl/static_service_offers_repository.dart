// lib/features/services/data/repositories/static_service_offers_repository.dart

import '../../domain/entities/service_offer_entity.dart';
import '../../domain/repositories/service_offers_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ServiceOffersRepository)
class StaticServiceOffersRepository implements ServiceOffersRepository {
  @override
  Future<List<ServiceOfferEntity>> getFeaturedOffers() async {
    await Future.delayed(const Duration(milliseconds: 400)); // محاكاة استدعاء شبكة
    return const [
      ServiceOfferEntity(
        id: '1',
        title: 'تركيب اجهزة حمايه',
        imageUrl:
            'https://images.unsplash.com/photo-1558002038-1055907df827?w=400',
        rating: 4.5,
        satisfiedCustomersCount: 20,
        price: null, // زي ما هو ظاهر في الصورة "0"
        categoryId: 'security',
      ),
      ServiceOfferEntity(
        id: '2',
        title: 'باقة التنظيف الشاملة',
        imageUrl:
            'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=400',
        rating: 4.5,
        satisfiedCustomersCount: 20,
        price: 200,
        categoryId: 'cleaning',
      ),
    ];
  }

  @override
  Future<List<ServiceOfferEntity>> getMostRequestedServices() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return const [
      ServiceOfferEntity(
        id: '3',
        title: 'تركيب المفاتيح والمقابس',
        imageUrl:
            'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?w=400',
        rating: 4.5,
        satisfiedCustomersCount: 20,
        price: null,
        categoryId: 'electrical',
      ),
      ServiceOfferEntity(
        id: '4',
        title: 'تركيب المفاتيح والمقابس',
        imageUrl:
            'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?w=400',
        rating: 4.5,
        satisfiedCustomersCount: 20,
        price: null,
        categoryId: 'electrical',
      ),
    ];
  }
}