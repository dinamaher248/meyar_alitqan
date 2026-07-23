import 'package:flutter/cupertino.dart';
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

class MainCategoriesGridView extends StatelessWidget {
  final String searchQuery;

  const MainCategoriesGridView({
    super.key,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
        GetMainCategoriesViewModel,
        GetMainCategoriesViewModelStates>(
      builder: (context, state) {
        if (state is GetMainCategoriesViewModelStatesLoading) {
          return WebMaxWidth(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: kIsWeb ? 2 : 4,
                crossAxisSpacing: RS.size(context, 12),
                mainAxisSpacing: RS.size(context, 12),
                childAspectRatio: 0.9,
              ),
              itemBuilder: (_, __) => const SubCategoryCardShimmer(),
            ),
          );
        }
        if (state is GetMainCategoriesViewModelStatesSuccess) {
          final filteredCategories = state.categories.where((category) {
            return category.name
                .toLowerCase()
                .contains(searchQuery.toLowerCase());
          }).toList();
          if (filteredCategories.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "لا توجد نتائج",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            );
          }

          if (kIsWeb) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent:
                    MediaQuery.of(context).size.width >= 1200 ? 360 : 260,
                mainAxisExtent:
                    MediaQuery.of(context).size.width >= 1200 ? 200 : 160,
                mainAxisSpacing: RS.size(context, 16),
                crossAxisSpacing: RS.size(context, 16),
              ),
              itemCount: filteredCategories.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
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
              },
            );
          }

          /// ===== Mobile: 4 columns fixed =====
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: RS.size(context, 12),
              crossAxisSpacing: RS.size(context, 8),
              childAspectRatio: 0.75,
            ),
            itemCount: filteredCategories.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
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
            },
          );
        } else {
          return WebMaxWidth(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: kIsWeb ? 2 : 4,
                crossAxisSpacing: RS.size(context, 12),
                mainAxisSpacing: RS.size(context, 12),
                childAspectRatio: 0.9,
              ),
              itemBuilder: (_, __) => const SubCategoryCardShimmer(),
            ),
          );
        }
      },
    );
  }
}

int _getCrossAxisCount(BuildContext context) {
  final width = MediaQuery.of(context).size.width;

  if (width >= 1200) return 5;
  if (width >= 900) return 4;
  if (width >= 600) return 3;
  return 2;
}