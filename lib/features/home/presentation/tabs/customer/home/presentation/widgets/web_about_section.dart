import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/helper/web_max_width.dart';
import 'package:meayar_alitqan/core/services/whatsapp_service.dart';
import 'package:meayar_alitqan/core/utils/assets_manager.dart';
import 'package:meayar_alitqan/core/utils/colors_manager.dart';
import 'package:meayar_alitqan/features/home/presentation/tabs/customer/home/presentation/widgets/web_about_image_slider.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

import 'marketing_hero_section.dart';

class WebAboutSection extends StatelessWidget {
  const WebAboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;

    final isDesktop = width >= 1024;
    final isMobileWeb = width < 768;

    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: isMobileWeb ? 40 : 64,
        ),
        color: Colors.white,
        child: Center(
          child: WebMaxWidth(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobileWeb ? 16 : 32,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ===== HEADER =====
                  Text(
                    loc.aboutLabel,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 12,
                      color: ColorsManager.primaryColor,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.3,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    loc.aboutTitle,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: isDesktop ? 28 : 24,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 12),

                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 640),
                    child: Text(
                      loc.aboutDescription,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 14,
                        height: 1.6,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  /// ===== CONTENT =====
                  if (isDesktop)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 6,
                          child: _InfoColumn(loc: loc),
                        ),
                        const SizedBox(width: 40),
                        const WebAboutImageSlider(),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        /// 📸 Images first (Mobile)
                        const WebAboutImageSlider(),
                        const SizedBox(height: 24),

                        /// 📦 Info containers under images
                        _InfoColumn(loc: loc),
                      ],
                    ),

                  const SizedBox(height: 32),

                  /// ===== CTA =====
                  SizedBox(
                    width: isMobileWeb ? double.infinity : null,
                    child: ElevatedButton(
                      onPressed: () {
                        WhatsAppService.openChat(
                          phone: "+962781319003",
                          message: loc.aboutWhatsappMessage,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.primaryColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        loc.aboutContactButton,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: isMobileWeb ? 60 : 100),

                  /// ===== MARKETING HERO =====
                  MarketingHeroSection(
                    phoneImage: AssetsManager.phone,
                    title: loc.hero_title,
                    description: loc.hero_description,
                    onGooglePlayTap: () {},
                    onAppStoreTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// ================= INFO COLUMN =================
class _InfoColumn extends StatelessWidget {
  final AppLocalizations loc;

  const _InfoColumn({required this.loc});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _InfoRow(
          title: loc.aboutScopeTitle,
          content: loc.aboutScopeDescription,
        ),
        const SizedBox(height: 16),
        _InfoRow(
          title: loc.aboutMethodologyTitle,
          content: loc.aboutMethodologyDescription,
        ),
        const SizedBox(height: 16),
        _InfoRow(
          title: loc.aboutQualityTitle,
          content: loc.aboutQualityDescription,
        ),
      ],
    );
  }
}

/// ================= INFO ROW =================
class _InfoRow extends StatelessWidget {
  final String title;
  final String content;

  const _InfoRow({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: ColorsManager.primaryColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  content,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 13,
                    height: 1.5,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
