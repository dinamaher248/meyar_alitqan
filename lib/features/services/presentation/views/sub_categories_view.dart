import 'package:flutter/material.dart';

import '../widgets/header_pages.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ===== Header =====
            HeaderPages(title: title),

            /// ===== Body =====
            Expanded(
              child: SubCategoriesViewBody(categoryId: categoryId),
            ),
          ],
        ),
      ),
    );
  }
}
