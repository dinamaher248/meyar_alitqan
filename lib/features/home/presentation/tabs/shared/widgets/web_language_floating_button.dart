import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/features/profile/shared/presentation/manager/language_view_model/language_view_model.dart';

import '../../../../../../core/utils/colors_manager.dart';

class WebLanguageFloatingButton extends StatelessWidget {
  const WebLanguageFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) return const SizedBox.shrink();

    final locale = context.watch<LanguageCubit>().state;

    return Positioned(
      bottom: 24,
      right: 24,
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(16),
        color: ColorsManager.primaryColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            final newCode =
            locale.languageCode == 'ar' ? 'en' : 'ar';
            context.read<LanguageCubit>().changeLanguage(newCode);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.language, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  locale.languageCode == 'ar' ? 'EN' : 'AR',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
