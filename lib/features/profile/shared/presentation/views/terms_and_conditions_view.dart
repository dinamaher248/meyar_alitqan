import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/core/di/di.dart';
import 'package:meayar_alitqan/features/profile/shared/presentation/manager/get_terms_and_condiations_view_model/get_terms_and_condiations_view_model.dart';
import 'package:meayar_alitqan/features/profile/shared/presentation/manager/language_view_model/language_view_model.dart';

import '../../../../../core/components/custom_app_bar.dart';
import '../../../../../l10n/app_localizations.dart';
import '../widgets/terms_and_conditions_view_body.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
  final currentLang = context.watch<LanguageCubit>().state.languageCode;
    return  Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.termsAndConditions,
      ),
      body: BlocProvider(
        create: (context) => getIt<GetTermsAndCondiationsViewModel>()..getTermsAndCondiations(
          lang: currentLang,
          docKey: 'terms',
        ),
        child: TermsAndConditionsViewBody()),
    );
  }
}
