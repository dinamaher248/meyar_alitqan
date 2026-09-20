import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/features/home/presentation/tabs/customer/home/presentation/widgets/maintenance_promo_banner.dart';

import '../../../../../../../../config/routes/routes_manager.dart';
import '../../../../../../../../core/components/search_text_field.dart';
import '../../../../../../../../core/helper/responsive_size.dart';
import '../../../../../../../../core/utils/colors_manager.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../../../../banners/presentation/manager/get_banners_view_model/get_banners_view_model.dart';
import '../../../../../../../banners/presentation/manager/get_banners_view_model/get_banners_view_model_states.dart';
import '../../../../../../../services/domain/entities/service_offer_entity.dart';
import '../../../../../../../services/presentation/manager/service_model_view_model/service_offers_view_model.dart';
import '../../../../../../../services/presentation/manager/service_model_view_model/service_offers_view_model_states.dart';
import '../../../../../../../services/presentation/views/customer_services_tab_view.dart';
import '../../../../../../../services/presentation/widgets/main_categories_list_view.dart';
import '../../../../../../../services/presentation/widgets/service_offer_card.dart';
import '../../../../shared/widgets/home_header.dart';

class CustomerHomeMobileLayout extends StatefulWidget {
  const CustomerHomeMobileLayout({super.key});

  @override
  State<CustomerHomeMobileLayout> createState() =>
      _CustomerHomeMobileLayoutState();
}

class _CustomerHomeMobileLayoutState extends State<CustomerHomeMobileLayout> {
  final searchController = TextEditingController();
  final List<ServiceOfferEntity> _staticOffers = const [
    ServiceOfferEntity(
      id: '1',
      title: 'تركيب اجهزة حمايه',
      imageUrl:
          'https://images.unsplash.com/photo-1558002038-1055907df827?w=400',
      rating: 4.5,
      satisfiedCustomersCount: 20,
      price: null,
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
  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetServiceOffersViewModel>().getFeaturedOffers();
      context.read<GetServiceOffersViewModel>().getMostRequestedServices();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          context.read<GetBannersViewModel>().getBanners(forceRefresh: true),
          context.read<GetServiceOffersViewModel>().getFeaturedOffers(),
          context.read<GetServiceOffersViewModel>().getMostRequestedServices(),
        ]);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ===== Header (Avatar + Notification) =====
            Padding(
              padding: EdgeInsets.fromLTRB(
                RS.size(context, 16),
                RS.size(context, 12),
                RS.size(context, 16),
                RS.size(context, 12),
              ),
              child: HomeHeader(
                onNotificationTap: () {
                  Navigator.pushNamed(context, RoutesManager.notificationsView);
                },
              ),
            ),

            /// ===== Search Field =====
            Padding(
              padding: EdgeInsets.symmetric(horizontal: RS.size(context, 16)),
              child: SearchTextField(
                hintText: loc.search,
                controller: searchController,
              ),
            ),

            SizedBox(height: RS.size(context, 16)),

            /// ===== Maintenance Banner =====
            BlocBuilder<GetBannersViewModel, GetBannersViewModelStates>(
              builder: (context, state) {
                if (state is GetBannersViewModelSuccess &&
                    state.banners.isNotEmpty) {
                  final maintenanceBanner = state.banners
                      .where((e) => e.position == 1)
                      .toList();

                  if (maintenanceBanner.isNotEmpty) {
                    final banner = maintenanceBanner.first;
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: RS.size(context, 16),
                      ),
                      child: const MaintenancePromoBanner(),
                    );
                  }
                }
                return const SizedBox.shrink();
              },
            ),

            SizedBox(height: RS.size(context, 24)),

            /// ===== Categories Section Header =====
            Padding(
              padding: EdgeInsets.symmetric(horizontal: RS.size(context, 16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loc.categories,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: RS.font(context, 18),
                      color: ColorsManager.primaryTextDarkColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CustomerServicesTabView(),
                        ),
                      );
                    },
                    child: Text(
                      loc.showMore,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: RS.font(context, 14),
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: RS.size(context, 12)),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: RS.size(context, 8)),
              child: MainCategoriesGridView(searchQuery: searchController.text),
            ),

            SizedBox(height: RS.size(context, 24)),

            /// ===== Offers Section Header =====
            Padding(
              padding: EdgeInsets.symmetric(horizontal: RS.size(context, 16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loc.ourServiceOffers,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: RS.font(context, 18),
                      color: ColorsManager.primaryTextDarkColor,
                    ),
                  ),
                  Text(
                    loc.showMore,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: RS.font(context, 14),
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: RS.size(context, 12)),

            /// ===== Dynamic Offers Grid =====
            BlocBuilder<
              GetServiceOffersViewModel,
              GetServiceOffersViewModelStates
            >(
              builder: (context, state) {
                if (state is GetServiceOffersViewModelLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetServiceOffersViewModelSuccess) {
                  if (state.featuredOffers.isEmpty) return const SizedBox.shrink();

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      const int crossAxisCount = 2;
                      final double spacing = RS.size(context, 12);
                      final double horizontalPadding = RS.size(context, 16) * 2;
                      final double availableWidth =
                          MediaQuery.of(context).size.width - horizontalPadding;
                      final double cardWidth =
                          (availableWidth - spacing * (crossAxisCount - 1)) /
                          crossAxisCount;

                      final double imageHeight = cardWidth * 11 / 16;
                      final double textBlockHeight =
                          RS.size(context, 10) * 2 +
                          (RS.font(context, 16) * 1.3) +
                          RS.size(context, 4) +
                          RS.size(context, 20) +
                          RS.size(context, 10) +
                          RS.size(context, 8) * 2 +
                          (RS.font(context, 14) * 1.3) +
                          RS.size(context, 8);

                      final double cardHeight = imageHeight + textBlockHeight;

                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: RS.size(context, 16),
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.featuredOffers.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: spacing,
                                mainAxisSpacing: spacing,
                                mainAxisExtent: cardHeight,
                              ),
                          itemBuilder: (context, index) {
                            final offer = state.featuredOffers[index];
                            return ServiceOfferCard(
                              offer: offer,
                              isOffer: true,
                              onTap: () {},
                              onBookNow: () {},
                            );
                          },
                        ),
                      );
                    },
                  );
                } else if (state is GetServiceOffersViewModelError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
            SizedBox(height: RS.size(context, 12)),
             /// ===== Offers Section Header =====
            Padding(
              padding: EdgeInsets.symmetric(horizontal: RS.size(context, 16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loc.ourServiceOffers,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: RS.font(context, 18),
                      color: ColorsManager.primaryTextDarkColor,
                    ),
                  ),
                  Text(
                    loc.showMore,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: RS.font(context, 14),
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: RS.size(context, 12)),

            /// ===== Dynamic Most Requested Services Grid =====
            BlocBuilder<
              GetServiceOffersViewModel,
              GetServiceOffersViewModelStates
            >(
              builder: (context, state) {
                if (state is GetServiceOffersViewModelLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetServiceOffersViewModelSuccess) {
                  if (state.mostRequestedServices.isEmpty) return const SizedBox.shrink();

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      const int crossAxisCount = 2;
                      final double spacing = RS.size(context, 12);
                      final double horizontalPadding = RS.size(context, 16) * 2;
                      final double availableWidth =
                          MediaQuery.of(context).size.width - horizontalPadding;
                      final double cardWidth =
                          (availableWidth - spacing * (crossAxisCount - 1)) /
                          crossAxisCount;

                      final double imageHeight = cardWidth * 11 / 16;
                      final double textBlockHeight =
                          RS.size(context, 10) * 2 +
                          (RS.font(context, 16) * 1.3) +
                          RS.size(context, 4) +
                          RS.size(context, 20) +
                          (RS.font(context, 14) * 1.3);

                      final double cardHeight = imageHeight + textBlockHeight;

                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: RS.size(context, 16),
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.mostRequestedServices.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: spacing,
                                mainAxisSpacing: spacing,
                                mainAxisExtent: cardHeight,
                              ),
                          itemBuilder: (context, index) {
                            final offer = state.mostRequestedServices[index];
                            return ServiceOfferCard(
                              offer: offer,
                              isOffer: false,
                              onTap: () {},
                              onBookNow: () {},
                            );
                          },
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
    
          ],
        ),
      ),
    );
  }
}
