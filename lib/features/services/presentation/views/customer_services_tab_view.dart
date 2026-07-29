import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/helper/responsive_size.dart';
import '../../../../../../../../core/utils/colors_manager.dart';
import '../../../../../../../../l10n/app_localizations.dart';
import '../manager/get_main_categories_view_model/get_main_categories_view_model.dart' show GetMainCategoriesViewModel;
import '../widgets/main_categories_list_view.dart';

class CustomerServicesTabView extends StatelessWidget {
  const CustomerServicesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ===== Header =====
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: RS.size(context, 16),
                vertical: RS.size(context, 12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.chevron_left,
                    color: ColorsManager.primaryTextDarkColor,
                    size: RS.size(context, 22),
                  ),
                  Text(
                    loc.categories,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: RS.font(context, 18),
                    ),
                  ),
                ],
              ),
            ),

            /// ===== Grid =====
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: RS.size(context, 8)),
                child: BlocProvider.value(
                  value: BlocProvider.of<GetMainCategoriesViewModel>(context),
                  child: const MainCategoriesGridView(searchQuery: ''),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}