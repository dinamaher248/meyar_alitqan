import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/helper/responsive_size.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../../../../core/components/custom_app_bar.dart';
import '../manager/get_main_categories_view_model/get_main_categories_view_model.dart'
    show GetMainCategoriesViewModel;
import '../widgets/main_categories_list_view.dart';

class CustomerServicesTabView extends StatelessWidget {
  const CustomerServicesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(title: loc.categories, centerTitle: true,showBackButton: false,),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ===== Grid =====
            SizedBox(height: RS.size(context, 10)),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: RS.size(context, 20)),
                child: BlocProvider.value(
                  value: BlocProvider.of<GetMainCategoriesViewModel>(context),
                  child: const MainCategoriesGridView(
                    searchQuery: '',
                    showAsTwoColumnsGrid: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
