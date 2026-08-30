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
        await context.read<GetBannersViewModel>().getBanners(
          forceRefresh: true,
        );
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

            // BlocBuilder<
            //   GetServiceOffersViewModel,
            //   GetServiceOffersViewModelStates
            // >(
            //   builder: (context, state) {
            //     if (state is GetServiceOffersViewModelSuccess) {
            //       return Padding(
            //         padding: EdgeInsets.symmetric(
            //           horizontal: RS.size(context, 16),
            //         ),
            //         child: GridView.builder(
            //           shrinkWrap: true,
            //           physics: const NeverScrollableScrollPhysics(),
            //           itemCount: state.offers.length,
            //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //             crossAxisCount: 2,
            //             crossAxisSpacing: RS.size(context, 12),
            //             mainAxisSpacing: RS.size(context, 12),
            //             childAspectRatio: 0.68,
            //           ),
            //           itemBuilder: (context, index) {
            //             final offer = state.offers[index];
            //             return ServiceOfferCard(
            //               offer: offer,
            //               onTap: () {},
            //               onBookNow: () {},
            //             );
            //           },
            //         ),
            //       );
            //     }
            //     return const SizedBox.shrink();
            //   },
            // ),
            LayoutBuilder(
              builder: (context, constraints) {
                const int crossAxisCount = 2;
                final double spacing = RS.size(context, 12);
                final double horizontalPadding = RS.size(context, 16) * 2;

                final double availableWidth =
                    MediaQuery.of(context).size.width - horizontalPadding;
                final double cardWidth =
                    (availableWidth - spacing * (crossAxisCount - 1)) /
                    crossAxisCount;

                // ارتفاع الصورة (نفس AspectRatio: 16/11 بالكارت بالظبط)
                final double imageHeight = cardWidth * 11 / 16;

                // ارتفاع بلوك النص + الزر تحت الصورة (نفس المقاسات الموجودة جوا الكارت بالظبط)
                final double textBlockHeight =
                    RS.size(context, 10) * 2 + // padding فوق وتحت
                    (RS.font(context, 16) * 1.3) + // سطر العنوان
                    RS.size(context, 4) + // مسافة
                    RS.size(context, 20) + // صف التقييم (نص + نجمة + وصف)
                    RS.size(context, 10) + // مسافة قبل الزر
                    RS.size(context, 8) * 2 + // padding عمودي بالزر
                    (RS.font(context, 14) * 1.3) + // سطر نص الزر
                    RS.size(context, 8); // هامش أمان إضافي

                final double cardHeight = imageHeight + textBlockHeight;

                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: RS.size(context, 16),
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _staticOffers.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,
                      mainAxisExtent: cardHeight, // بدل childAspectRatio
                    ),
                    itemBuilder: (context, index) {
                      final offer = _staticOffers[index];
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
            ),
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
                  Text(
                    loc.showMore,
                    style: TextStyle(
                      fontSize: RS.font(context, 14),
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: RS.size(context, 12)),
            LayoutBuilder(
              builder: (context, constraints) {
                const int crossAxisCount = 2;
                final double spacing = RS.size(context, 12);
                final double horizontalPadding = RS.size(context, 16) * 2;

                final double availableWidth =
                    MediaQuery.of(context).size.width - horizontalPadding;
                final double cardWidth =
                    (availableWidth - spacing * (crossAxisCount - 1)) /
                    crossAxisCount;

                // ارتفاع الصورة (نفس AspectRatio: 16/11 بالكارت بالظبط)
                final double imageHeight = cardWidth * 11 / 16;

                // ارتفاع بلوك النص + الزر تحت الصورة (نفس المقاسات الموجودة جوا الكارت بالظبط)
                final double textBlockHeight =
                    RS.size(context, 10) * 2 + // padding فوق وتحت
                    (RS.font(context, 16) * 1.3) + // سطر العنوان
                    RS.size(context, 4) + // مسافة
                    RS.size(context, 20) + // صف التقييم (نص + نجمة + وصف)
                    (RS.font(context, 14) * 1.3);

                final double cardHeight = imageHeight + textBlockHeight;

                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: RS.size(context, 16),
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _staticOffers.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,
                      mainAxisExtent: cardHeight, // بدل childAspectRatio
                    ),
                    itemBuilder: (context, index) {
                      final offer = _staticOffers[index];
                      return ServiceOfferCard(
                        offer: offer,
                        onTap: () {},
                        onBookNow: () {},
                      );
                    },
                  ),
                );
              },
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: RS.size(context, 16)),
            //   child: GridView.builder(
            //     shrinkWrap: true,
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemCount: _staticOffers.length,
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2,
            //       crossAxisSpacing: RS.size(context, 12),
            //       mainAxisSpacing: RS.size(context, 12),
            //       childAspectRatio: 0.98,
            //     ),
            //     itemBuilder: (context, index) {
            //       final offer = _staticOffers[index];
            //       return ServiceOfferCard(
            //         offer: offer,
            //         onTap: () {},
            //         onBookNow: () {},
            //       );
            //     },
            //   ),
            // ),

            // BlocBuilder<GetBannersViewModel, GetBannersViewModelStates>(
            //   builder: (context, state) {
            //     if (state is GetBannersViewModelSuccess &&
            //         state.banners.isNotEmpty) {
            //       final normalBanners = state.banners
            //           .where((e) => e.position == 0)
            //           .toList();

            //       if (normalBanners.isNotEmpty) {
            //         return SizedBox(
            //           height: RS.size(context, 200),
            //           child: ListView.separated(
            //             scrollDirection: Axis.horizontal,
            //             padding: EdgeInsets.symmetric(
            //               horizontal: RS.size(context, 16),
            //             ),
            //             itemCount: normalBanners.length,
            //             separatorBuilder: (_, __) =>
            //                 SizedBox(width: RS.size(context, 12)),
            //             itemBuilder: (context, index) {
            //               // Placeholder card - استبدليها بالكارت الحقيقي
            //               return Container(
            //                 width: RS.size(context, 160),
            //                 decoration: BoxDecoration(
            //                   color: Colors.white,
            //                   borderRadius: BorderRadius.circular(
            //                     RS.radius(context, 12),
            //                   ),
            //                   boxShadow: [
            //                     BoxShadow(
            //                       color: Colors.black.withValues(alpha: 0.05),
            //                       blurRadius: 8,
            //                       offset: const Offset(0, 4),
            //                     ),
            //                   ],
            //                 ),
            //                 clipBehavior: Clip.antiAlias,
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.stretch,
            //                   children: [
            //                     AspectRatio(
            //                       aspectRatio: 16 / 10,
            //                       child: Image.network(
            //                         normalBanners[index].imageUrl,
            //                         fit: BoxFit.cover,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               );
            //             },
            //           ),
            //         );
            //       }
            //     }
            //     return const SizedBox.shrink();
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
