import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper/responsive_size.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../manager/language_view_model/language_view_model.dart';
import 'language_item.dart';

Future<void> showLanguagePickerSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _LanguagePickerSheet(),
  );
}

class _LanguagePickerSheet extends StatelessWidget {
  const _LanguagePickerSheet();

  @override
  Widget build(BuildContext context) {
    final currentLang = context.watch<LanguageCubit>().state.languageCode;

    return Container(
      padding: EdgeInsets.all(RS.size(context, 16)),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LanguageItem(
            title: 'العربية',
            flag: AssetsManager.arabicLanguage,
            isSelected: currentLang == 'ar',
            onTap: () {
              context.read<LanguageCubit>().changeLanguage('ar');
              Navigator.pop(context);
            },
          ),
          SizedBox(height: RS.size(context, 13)),
          LanguageItem(
            title: 'English',
            flag: AssetsManager.englishLanguage,
            isSelected: currentLang == 'en',
            onTap: () {
              context.read<LanguageCubit>().changeLanguage('en');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}