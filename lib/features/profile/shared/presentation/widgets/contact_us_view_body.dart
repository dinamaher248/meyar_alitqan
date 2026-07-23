import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/services/whatsapp_service.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../core/utils/assets_manager.dart';
import '../../../../../../../core/utils/colors_manager.dart';

class ContactUsViewBody extends StatelessWidget {
  const ContactUsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;

    final isMobile = width < 600;
    final isWebMobile = width >= 600 && width < 1024;
    final isDesktop = width >= 1024;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 900 : 600,
          ),
          child: Column(
            children: [
              _buildContactInfoSection(context),
              const SizedBox(height: 24),

              if (isDesktop)
                Row(
                  children: [
                    Expanded(
                      child: _buildWhatsappCard(t),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildEmailCard(
                        t.contact_email_address,
                        context: context,
                      ),
                    ),
                  ],
                )
              else ...[
                _buildWhatsappCard(t),
                const SizedBox(height: 24),
                _buildEmailCard(
                  t.contact_email_address,
                  context: context,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /* ================= INFO SECTION ================= */

  Widget _buildContactInfoSection(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorsManager.primaryColor.withOpacity(0.12),
            ColorsManager.primaryColor.withOpacity(0.05),
          ],
        ),
        border: Border.all(
          color: ColorsManager.primaryColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 32,
            color: ColorsManager.primaryColor,
          ),
          const SizedBox(height: 12),
          Text(
            t.contact_info_title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorsManager.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            t.contact_info_description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            t.contact_location,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  /* ================= WHATSAPP CARD ================= */

  Widget _buildWhatsappCard(AppLocalizations t) {
    return _buildContactCard(
      iconPath: AssetsManager.whatsapp,
      title: t.contact_whatsapp_title,
      subtitle: t.contact_whatsapp_number,
      color: const Color(0xFF25D366),
      onTap: () {
        WhatsAppService.openChat(
          phone: "+962781319003",
          message: "",
        );
      },
    );
  }

  /* ================= EMAIL CARD ================= */

  Widget _buildEmailCard(
      String email, {
        required BuildContext context,
      }) {
    final t = AppLocalizations.of(context)!;

    return _buildContactCard(
      icon: Icons.email_rounded,
      title: t.contact_email_title,
      subtitle: email,
      color: Colors.orange,
      onTap: () async {
        final Uri emailUri = Uri(
          scheme: 'mailto',
          path: email,
        );
        if (await canLaunchUrl(emailUri)) {
          await launchUrl(emailUri);
        }
      },
    );
  }

  /* ================= BASE CARD ================= */

  Widget _buildContactCard({
    String? iconPath,
    IconData? icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.25)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.12),
              ),
              child: iconPath != null
                  ? Image.asset(
                iconPath,
                height: 26,
                width: 26,
                color: color,
              )
                  : Icon(icon, color: color, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
