import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/sub_category_card.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/sub_category_card_shimmer.dart';

import '../../../../config/routes/routes_manager.dart';
import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../l10n/app_localizations.dart';
import '../manager/get_sub_categories_view_model/get_sub_categories_view_model.dart';
import '../manager/get_sub_categories_view_model/get_sub_categories_view_model_states.dart';
class SubCategoriesGridView extends StatelessWidget {
    SubCategoriesGridView({super.key,required this.mainCategoryId});
  String mainCategoryId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
        GetSubCategoriesViewModel,
        GetSubCategoriesViewModelStates>(
      builder: (context, state) {
        if (state is GetSubCategoriesViewModelStatesLoading) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _subGridCount(context),
              crossAxisSpacing: RS.size(context, 12),
              mainAxisSpacing: RS.size(context, 12),
              childAspectRatio: 0.9,
            ),
            itemBuilder: (_, __) => const SubCategoryCardShimmer(),
          );

        }
        if (state is GetSubCategoriesViewModelStatesSuccess) {
          if (state.categories.isEmpty) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,

              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Image.asset(
                    AssetsManager.waiting,
                    fit: BoxFit.cover,
                    height: RS.size(context, 200),
                  ),
                  SizedBox(height: RS.size(context, 16)),
                  Text(
                    AppLocalizations.of(context)!.noServices,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: RS.font(context, 20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.categories.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery.of(context).size.width >= 1200
                  ? 360
                  : 260,

              mainAxisExtent: MediaQuery.of(context).size.width >= 1200
                  ? 200
                  : 240, // موبايل / تابلت

              mainAxisSpacing: RS.size(context, 16),
              crossAxisSpacing: RS.size(context, 16),
            ),
            itemBuilder: (context, index) {
              final subCategory = state.categories[index];

              return CategoryCard(
                subtitle: '',
                image: subCategory.icon ?? "",
                title: subCategory.name,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RoutesManager.servicesSubCategorySelectionView,
                    arguments: {
                      "title": subCategory.name,
                      "categoryId": subCategory.id,
                      "mainCategoryId": mainCategoryId,
                    },
                  );
                },
              );
            },
          );

        } else {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _subGridCount(context),
              crossAxisSpacing: RS.size(context, 12),
              mainAxisSpacing: RS.size(context, 12),
              childAspectRatio: 0.9,
            ),
            itemBuilder: (_, __) => const SubCategoryCardShimmer(),
          );
        }
      },
    );
  }
}
int _subGridCount(BuildContext context) {
  final width = MediaQuery.of(context).size.width;

  if (width >= 1200) return 5;
  if (width >= 900) return 4;
  if (width >= 600) return 3;
  return 2;
}
