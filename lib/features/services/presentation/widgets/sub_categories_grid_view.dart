import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/routes_manager.dart';
import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/colors_manager.dart';
import '../../../../l10n/app_localizations.dart';
import '../manager/get_sub_categories_view_model/get_sub_categories_view_model.dart';
import '../manager/get_sub_categories_view_model/get_sub_categories_view_model_states.dart';

class SubCategoriesGridView extends StatelessWidget {
  SubCategoriesGridView({super.key, required this.mainCategoryId});

  String mainCategoryId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      GetSubCategoriesViewModel,
      GetSubCategoriesViewModelStates
    >(
      builder: (context, state) {
        if (state is GetSubCategoriesViewModelStatesLoading) {
          return _buildList(
            context,
            itemCount: 6,
            itemBuilder: (_, __) => const _SubCategoryTileShimmer(),
          );
        }

        if (state is GetSubCategoriesViewModelStatesSuccess) {
          if (state.categories.isEmpty) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
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

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: RS.size(context, 32)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: RS.size(context, 8)),
                child: Text(
                  "اختر الخدمه المناسبه لك",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: RS.font(context, 20),
                    color: ColorsManager.primaryTextDarkColor,
                  ),
                ),
              ),

              SizedBox(height: RS.size(context, 12)),

              _buildList(
                context,
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  final subCategory = state.categories[index];

                  return _SubCategoryTile(
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
              ),
            ],
          );
        }

        return _buildList(
          context,
          itemCount: 6,
          itemBuilder: (_, __) => const _SubCategoryTileShimmer(),
        );
      },
    );
  }

  Widget _buildList(
    BuildContext context, {
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: RS.size(context, 8)),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        separatorBuilder: (_, __) => SizedBox(height: RS.size(context, 12)),
        itemBuilder: itemBuilder,
      ),
    );
  }
}

/// ===== List item matching the design =====
class _SubCategoryTile extends StatelessWidget {
  const _SubCategoryTile({required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(RS.radius(context, 10)),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: RS.size(context, 16),
          vertical: RS.size(context, 16),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(RS.radius(context, 10)),
          border: Border.all(color: ColorsManager.grey, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: RS.font(context, 16),
                fontWeight: FontWeight.w500,
                color: ColorsManager.primaryColor,
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: RS.size(context, 18),
              color: ColorsManager.primaryTextDarkColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _SubCategoryTileShimmer extends StatelessWidget {
  const _SubCategoryTileShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: RS.size(context, 52),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(RS.radius(context, 10)),
      ),
    );
  }
}
