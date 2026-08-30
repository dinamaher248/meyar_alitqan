import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/helper/responsive_size.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/utils/colors_manager.dart';
import '../../../profile/shared/presentation/manager/language_view_model/language_view_model.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // IconButton(
          //   onPressed: () => Navigator.pop(context),
          //   icon: Icon(Icons.arrow_back_ios, size: RS.size(context, 20)),
          // ),
          _LanguageSwitcher(),
        ],
      ),
    );
  }
}

class _LanguageSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentLang = context.watch<LanguageCubit>().state.languageCode;
    return GestureDetector(
      onTap: () {
        context.read<LanguageCubit>().changeLanguage(
          currentLang == 'ar' ? 'en' : 'ar',
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: ColorsManager.white,
            borderRadius: BorderRadius.circular(RS.radius(context, 5)),
            border: Border.all(
              color: ColorsManager.grey,
              width: RS.size(context, 1),
            ),
          ),
          padding: const EdgeInsets.all(6),
          child: Row(
            children: [
              SvgPicture.asset(
                AssetsManager.globe,
                height: RS.size(context, 18),
              ),
              SizedBox(width: RS.size(context, 8)),
              Text(
                currentLang == 'ar' ? 'AR' : 'EN',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: RS.font(context, 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
