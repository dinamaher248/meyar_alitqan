import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/features/services/presentation/manager/get_main_categories_view_model/get_main_categories_view_model.dart';
import 'package:meayar_alitqan/features/services/presentation/manager/get_main_categories_view_model/get_main_categories_view_model_states.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/sub_category_card.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/sub_category_card_shimmer.dart';

import '../../../../config/routes/routes_manager.dart';
import '../../../../core/helper/responsive_size.dart';
import '../../../../core/helper/web_max_width.dart';
import '../../../../l10n/app_localizations.dart';

class MainCategoriesGridView extends StatelessWidget {
  final String searchQuery;

  final bool showAsTwoColumnsGrid;

  const MainCategoriesGridView({
    super.key,
    required this.searchQuery,
    this.showAsTwoColumnsGrid = false,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return BlocBuilder<
      GetMainCategoriesViewModel,
      GetMainCategoriesViewModelStates
    >(
      builder: (context, state) {
        if (state is GetMainCategoriesViewModelStatesLoading) {
          final loadingContent = showAsTwoColumnsGrid
              ? _CategoriesTwoColumnsGrid(
                  itemCount: 10,
                  itemBuilder: (_, __) => const SubCategoryCardShimmer(),
                )
              : _CategoriesRow(
                  itemCount: 10,
                  itemBuilder: (_, __) => const SubCategoryCardShimmer(),
                );
          return WebMaxWidth(child: loadingContent);
        }
        if (state is GetMainCategoriesViewModelStatesSuccess) {
          final filteredCategories = state.categories.where((category) {
            return category.name.toLowerCase().contains(
              searchQuery.toLowerCase(),
            );
          }).toList();

          if (filteredCategories.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  loc.thereIsNoResult,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            );
          }

          Widget itemBuilder(BuildContext context, int index) {
            final category = filteredCategories[index];

            return CategoryCard(
              subtitle: '',
              image: category.icon ?? "",
              title: category.name,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RoutesManager.subCategoriesView,
                  arguments: {
                    "title": category.name,
                    "categoryId": category.id,
                  },
                );
              },
            );
          }

          Widget grid = showAsTwoColumnsGrid
              ? _CategoriesTwoColumnsGrid(
                  itemCount: filteredCategories.length,
                  itemBuilder: itemBuilder,
                )
              : _CategoriesRow(
                  itemCount: filteredCategories.length,
                  itemBuilder: itemBuilder,
                );

          return kIsWeb ? WebMaxWidth(child: grid) : grid;
        } else {
          final fallbackContent = showAsTwoColumnsGrid
              ? _CategoriesTwoColumnsGrid(
                  itemCount: 10,
                  itemBuilder: (_, __) => const SubCategoryCardShimmer(),
                )
              : _CategoriesRow(
                  itemCount: 10,
                  itemBuilder: (_, __) => const SubCategoryCardShimmer(),
                );
          return WebMaxWidth(child: fallbackContent);
        }
      },
    );
  }
}

class _CategoriesRow extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  const _CategoriesRow({required this.itemCount, required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double availableWidth = constraints.maxWidth;

        final int visibleCount = _visibleCardsCount(availableWidth);

        final double spacing = RS.size(context, 12);
        final double cardWidth =
            (availableWidth - (spacing * (visibleCount - 1))) / visibleCount;

        final double cardHeight = kIsWeb
            ? (availableWidth >= 1200
                  ? RS.size(context, 200)
                  : RS.size(context, 160))
            : cardWidth / 0.81;

        return SizedBox(
          height: cardHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: itemCount,
            separatorBuilder: (_, __) => SizedBox(width: spacing),
            itemBuilder: (context, index) {
              return SizedBox(
                width: cardWidth,
                child: itemBuilder(context, index),
              );
            },
          ),
        );
      },
    );
  }

  int _visibleCardsCount(double width) {
    if (kIsWeb) {
      if (width >= 1200) return 4;
      if (width >= 900) return 3;
      return 2;
    }
    if (width >= 900) return 6;
    if (width >= 600) return 5;
    if (width >= 380) return 4;
    return 3;
  }
}

class _CategoriesTwoColumnsGrid extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  const _CategoriesTwoColumnsGrid({
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const int crossAxisCount = 2;
        final double spacing = RS.size(context, 12);

        final double cardWidth =
            (constraints.maxWidth - spacing * (crossAxisCount - 1)) /
            crossAxisCount;

        // نفس نسبة الارتفاع/العرض المستخدمة بالصف الأفقي (0.81) عشان
        // شكل الكارت الواحد يضل مطابق تمامًا لباقي الصفحات.
        final double cardHeight = cardWidth / 0.99;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            mainAxisExtent: cardHeight,
          ),
          itemBuilder: itemBuilder,
        );
      },
    );
  }
}
