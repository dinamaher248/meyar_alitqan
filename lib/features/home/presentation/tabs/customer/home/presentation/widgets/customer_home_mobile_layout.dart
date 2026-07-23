import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meayar_alitqan/features/home/presentation/tabs/customer/home/presentation/widgets/maintenance_promo_banner.dart';

import '../../../../../../../../config/routes/routes_manager.dart';
import '../../../../../../../../core/helper/responsive_size.dart';
import '../../../../../../../../core/services/whatsapp_service.dart';
import '../../../../../../../../core/utils/assets_manager.dart';
import '../../../../../../../../core/utils/colors_manager.dart';
import '../../../../../../../../l10n/app_localizations.dart';

import '../../../../../../../banners/presentation/manager/get_banners_view_model/get_banners_view_model.dart';
import '../../../../../../../banners/presentation/manager/get_banners_view_model/get_banners_view_model_states.dart';
import '../../../../../../../banners/presentation/widgets/banner_section.dart';
import '../../../../../../../services/presentation/widgets/main_categories_list_view.dart';
import '../../../../shared/widgets/home_header.dart';
import '../../../../../../../../core/components/search_text_field.dart';

class CustomerHomeMobileLayout extends StatefulWidget {
  const CustomerHomeMobileLayout({super.key});

  @override
  State<CustomerHomeMobileLayout> createState() =>
      _CustomerHomeMobileLayoutState();
}

class _CustomerHomeMobileLayoutState extends State<CustomerHomeMobileLayout> {
  final searchController = TextEditingController();

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
                      fontWeight: FontWeight.bold,
                      fontSize: RS.font(context, 16),
                    ),
                  ),
                   Text(
                    "عرض المزيد",
                    style: TextStyle(
                      fontSize: RS.font(context, 13),
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.primaryColor,
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
                      fontWeight: FontWeight.bold,
                      fontSize: RS.font(context, 16),
                    ),
                  ),
                  Text(
                    "عرض المزيد",
                    style: TextStyle(
                      fontSize: RS.font(context, 13),
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: RS.size(context, 12)),

            /// ===== TODO: كروت العروض المتاحة =====
            /// محتاجة الـ Widget/Entity الحقيقي هنا. لو عندك Card جاهز
            /// (زي service_offer_card.dart) استبدلي الـ Placeholder ده بيه.
            BlocBuilder<GetBannersViewModel, GetBannersViewModelStates>(
              builder: (context, state) {
                if (state is GetBannersViewModelSuccess &&
                    state.banners.isNotEmpty) {
                  final normalBanners = state.banners
                      .where((e) => e.position == 0)
                      .toList();

                  if (normalBanners.isNotEmpty) {
                    return SizedBox(
                      height: RS.size(context, 200),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(
                          horizontal: RS.size(context, 16),
                        ),
                        itemCount: normalBanners.length,
                        separatorBuilder: (_, __) =>
                            SizedBox(width: RS.size(context, 12)),
                        itemBuilder: (context, index) {
                          // Placeholder card - استبدليها بالكارت الحقيقي
                          return Container(
                            width: RS.size(context, 160),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                RS.radius(context, 12),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                AspectRatio(
                                  aspectRatio: 16 / 10,
                                  child: Image.network(
                                    normalBanners[index].imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                }
                return const SizedBox.shrink();
              },
            ),

            SizedBox(height: RS.size(context, 32)),
          ],
        ),
      ),
    );
  }
}
