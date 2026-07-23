import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/core/components/custom_app_bar.dart';
import 'package:meayar_alitqan/core/di/di.dart';
import 'package:meayar_alitqan/features/profile/shared/presentation/manager/get_terms_and_condiations_view_model/get_terms_and_condiations_view_model.dart';
import 'package:meayar_alitqan/features/profile/shared/presentation/manager/language_view_model/language_view_model.dart';
import 'package:meayar_alitqan/features/profile/shared/presentation/widgets/privacy_policy_view_body.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

class  PrivacyPolicyView extends StatelessWidget {
  const  PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLang = context.watch<LanguageCubit>().state.languageCode;
    return  Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.privacyPolicy,
      ),
     body: BlocProvider(
        create: (context) => getIt<GetTermsAndCondiationsViewModel>()..getTermsAndCondiations(
          lang: currentLang,
          docKey: 'privacy',
        ),
        child: PrivacyPolicyViewBody()),
    );
  }
}