import 'package:flutter/material.dart';

import '../../../../core/components/custom_app_bar.dart';
import '../widgets/sub_services_view_body.dart';

class SubServicesView extends StatelessWidget {
  const SubServicesView({
    super.key,
    required this.categoryId,
    required this.title,
    required this.mainCategoryId,
  });

  final String categoryId;
  final String title;
  final String mainCategoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: SafeArea(
        child: SubServicesViewBody(
          categoryId: categoryId,
          mainCategoryId: mainCategoryId,
        ),
      ),
    );
  }
}
