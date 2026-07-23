import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/sub_categories_grid_view.dart';

import '../../../../core/di/di.dart';
import '../../../../core/helper/web_max_width.dart';
import '../manager/get_sub_categories_view_model/get_sub_categories_view_model.dart';

class SubCategoriesViewBody extends StatelessWidget {
  const SubCategoriesViewBody({super.key, required this.categoryId});

  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocProvider(
                create: (context) =>
                    getIt<GetSubCategoriesViewModel>()
                      ..getSubCategories(categoryId),
                child:  WebMaxWidth(
                  child: SubCategoriesGridView(mainCategoryId: categoryId),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
