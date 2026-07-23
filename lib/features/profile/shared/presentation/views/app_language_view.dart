import 'package:flutter/material.dart';

import '../../../../../core/components/custom_app_bar.dart';
import '../../../../../l10n/app_localizations.dart';
import '../widgets/app_language_view_body.dart';

class AppLanguageView extends StatelessWidget {
  const AppLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.appLanguage,
      ),
      body: AppLanguageViewBody(),
    );
  }
}
