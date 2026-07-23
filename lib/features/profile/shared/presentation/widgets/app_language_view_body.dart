import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper/responsive_size.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../manager/language_view_model/language_view_model.dart';
import 'language_item.dart';

class AppLanguageViewBody extends StatelessWidget {
  const AppLanguageViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLang =
        context.watch<LanguageCubit>().state.languageCode;


    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(RS.size(context, 16)),
        child: Column(
          children: [
            LanguageItem(
              title: 'العربية',
              flag: AssetsManager.arabicLanguage,
              isSelected: currentLang == 'ar',
              onTap: () {
                context.read<LanguageCubit>().changeLanguage('ar');
              },
            ),
            SizedBox(height: RS.size(context, 12)),
            LanguageItem(
              title: 'English',
              flag: AssetsManager.englishLanguage,
              isSelected: currentLang == 'en',
              onTap: () {
                context.read<LanguageCubit>().changeLanguage('en');
              },
            ),
          ],
        ),
      ),
    );
  }
}
