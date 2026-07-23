import 'package:flutter/material.dart';

import '../../../../core/components/custom_app_bar.dart';
import '../widgets/sub_categories_view_body.dart';

class SubCategoriesView extends StatelessWidget {
  const SubCategoriesView({
    super.key,
    required this.title,
    required this.categoryId,
  });

  final String title;
  final String categoryId;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: SafeArea(child: SubCategoriesViewBody(categoryId: categoryId)),
    );
  }
}
