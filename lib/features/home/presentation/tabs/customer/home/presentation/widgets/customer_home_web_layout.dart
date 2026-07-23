import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meayar_alitqan/features/home/presentation/tabs/customer/home/presentation/widgets/web_about_section.dart';
import 'package:meayar_alitqan/features/home/presentation/tabs/customer/home/presentation/widgets/web_hero_section.dart';

import '../../../../../../../../core/helper/web_max_width.dart';
import '../../../../../../../../core/services/whatsapp_service.dart';
import '../../../../../../../../core/utils/assets_manager.dart';
import '../../../../../../../../core/utils/colors_manager.dart';
import '../../../../../../../../l10n/app_localizations.dart';

import '../../../../../../../banners/presentation/manager/get_banners_view_model/get_banners_view_model.dart';
import '../../../../../../../banners/presentation/manager/get_banners_view_model/get_banners_view_model_states.dart';
import '../../../../../../../banners/presentation/widgets/banner_section.dart';
import '../../../../../../../services/presentation/manager/get_main_categories_view_model/get_main_categories_view_model.dart';
import '../../../../../../../services/presentation/widgets/main_categories_list_view.dart';
import '../../../../shared/widgets/home_header.dart';
import '../../../../../../../../core/components/search_text_field.dart';

class CustomerHomeWebLayout extends StatefulWidget {
  const CustomerHomeWebLayout({super.key});

  @override
  State<CustomerHomeWebLayout> createState() => _CustomerHomeWebLayoutState();
}

class _CustomerHomeWebLayoutState extends State<CustomerHomeWebLayout> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });

    context.read<GetMainCategoriesViewModel>().getMainCategories();
    context.read<GetBannersViewModel>().getBanners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final isMobileWeb = width < 600;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          BlocBuilder<GetBannersViewModel, GetBannersViewModelStates>(
            builder: (context, state) {
              if (state is GetBannersViewModelSuccess &&
                  state.banners.isNotEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: isMobileWeb ? 16 : 40,
                  ),
                  child: isMobileWeb
                      ? SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: BannerSection(
                        hideDots: false,
                        useFadeAnimation: true,
                        images:
                        state.banners.map((e) => e.imageUrl).toList(),
                      ),
                    ),
                  )

                      : WebMaxWidth(
                    child: SizedBox(
                      height: 360,
                      child: BannerSection(
                        hideDots: true,
                        useFadeAnimation: true,
                        images:
                        state.banners.map((e) => e.imageUrl).toList(),
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),


          const SizedBox(height: 40),


          WebMaxWidth(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    AssetsManager.category,
                    width: 26,
                    height: 26,
                    color: ColorsManager.primaryColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    loc.categories,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),

            WebMaxWidth(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child:  MainCategoriesGridView(
                searchQuery: searchController.text,
              ),
            ),
          ),
        ],
      ),
    );

  }
}
