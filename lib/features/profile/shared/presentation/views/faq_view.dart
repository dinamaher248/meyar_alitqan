import 'package:flutter/material.dart';

import '../../../../../core/components/custom_app_bar.dart';
import '../../../../../l10n/app_localizations.dart';
import '../widgets/faq_view_body.dart';

class FaqView extends StatelessWidget {
  const FaqView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.faq,
      ),
      body: FaqViewBody(),
    );
  }
}
