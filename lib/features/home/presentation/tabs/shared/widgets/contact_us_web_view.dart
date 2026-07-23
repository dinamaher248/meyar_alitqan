import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/helper/web_max_width.dart';
import 'package:meayar_alitqan/core/utils/colors_manager.dart';
import 'package:meayar_alitqan/core/utils/constants_manager.dart';
import 'package:meayar_alitqan/core/utils/strings_manager.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';
import '../widgets/info_card.dart';
import '../widgets/contact_form.dart';

class ContactUsWebPage extends StatelessWidget {
  const ContactUsWebPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobileWeb = width < 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.contact_title_small,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  Text(
                      AppLocalizations.of(context)!.contact_title_main,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Text(
                      AppLocalizations.of(context)!.contact_description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 15, height: 1.8, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),

            Center(
              child: WebMaxWidth(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobileWeb
                        ? ConstantsManager.formPaddingMobile
                        : ConstantsManager.formPaddingWeb,
                    vertical: isMobileWeb
                        ? ConstantsManager.formVerticalPaddingMobile
                        : ConstantsManager.formVerticalPaddingWeb,
                  ),
                  color: ColorsManager.primaryColor.withOpacity(.2),
                  child: Column(
                    children: [
                      isMobileWeb
                          ? Column(
                              children: [
                                InfoCard(
                                  title:  AppLocalizations.of(context)!.email,
                                  value:      AppLocalizations.of(context)!.email,
                                  icon: Icons.email,
                                ),
                                const SizedBox(height: 16),
                                InfoCard(
                                  title:  AppLocalizations.of(context)!.phone,
                                  value:      AppLocalizations.of(context)!.phone,
                                  icon: Icons.phone,
                                ),
                                const SizedBox(height: 16),
                                InfoCard(
                                  title:  AppLocalizations.of(context)!.location,
                                  value:  AppLocalizations.of(context)!.contact_location,
                                  icon: Icons.location_on,
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InfoCard(
                                  title: AppLocalizations.of(context)!.email,
                                  value: StringsManager.email,
                                  icon: Icons.email,
                                ),
                                const SizedBox(width: 24),
                                InfoCard(
                                  title: AppLocalizations.of(context)!.phone,
                                  value: StringsManager.phoneNumber,
                                  icon: Icons.phone,
                                ),
                                const SizedBox(width: 24),
                                InfoCard(
                                  title:  AppLocalizations.of(context)!.location,
                                                 value:  AppLocalizations.of(context)!.contact_location,
                                  icon: Icons.location_on,
                                ),
                              ],
                            ),

                      const SizedBox(height: 60),

                      const ContactForm(),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
