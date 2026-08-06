import 'package:flutter/material.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

import '../../../../../../../core/components/custom_app_bar.dart';
import '../widgets/contact_us_view_body.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.contactUs,
        centerTitle: true,
      ),
      body: const ContactUsViewBody(),
    );
  }
}
