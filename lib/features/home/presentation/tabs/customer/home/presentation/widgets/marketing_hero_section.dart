import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/utils/assets_manager.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

class MarketingHeroSection extends StatelessWidget {
  const MarketingHeroSection({
    super.key,
    required this.phoneImage,
    required this.title,
    required this.description,
    required this.onGooglePlayTap,
    required this.onAppStoreTap,
  });

  final String phoneImage;
  final String title;
  final String description;
  final VoidCallback onGooglePlayTap;
  final VoidCallback onAppStoreTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;
    final isMobile = width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: isMobile ? 32 : 60,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF2D0B52),
            Color(0xFF7A4EE0),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 30,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: isDesktop
          ? _DesktopLayout(
        phoneImage: phoneImage,
        title: title,
        description: description,
        onGooglePlayTap: onGooglePlayTap,
        onAppStoreTap: onAppStoreTap,
      )
          : _MobileLayout(
        phoneImage: phoneImage,
        title: title,
        description: description,
        onGooglePlayTap: onGooglePlayTap,
        onAppStoreTap: onAppStoreTap,
      ),
    );
  }
}

/* =========================
   DESKTOP LAYOUT
========================= */
class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({
    required this.phoneImage,
    required this.title,
    required this.description,
    required this.onGooglePlayTap,
    required this.onAppStoreTap,
  });

  final String phoneImage;
  final String title;
  final String description;
  final VoidCallback onGooglePlayTap;
  final VoidCallback onAppStoreTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// PHONE
        Expanded(
          flex: 4,
          child: Center(
            child: Image.asset(
              phoneImage,
              height: 520,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(width: 60),

        /// CONTENT
        Expanded(
          flex: 6,
          child: _Content(
            title: title,
            description: description,
            onGooglePlayTap: onGooglePlayTap,
            onAppStoreTap: onAppStoreTap,
          ),
        ),
      ],
    );
  }
}

/* =========================
   MOBILE LAYOUT
========================= */
class _MobileLayout extends StatelessWidget {
  const _MobileLayout({
    required this.phoneImage,
    required this.title,
    required this.description,
    required this.onGooglePlayTap,
    required this.onAppStoreTap,
  });

  final String phoneImage;
  final String title;
  final String description;
  final VoidCallback onGooglePlayTap;
  final VoidCallback onAppStoreTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// TEXT
        _Content(
          title: title,
          description: description,
          onGooglePlayTap: onGooglePlayTap,
          onAppStoreTap: onAppStoreTap,
          centerText: true,
        ),

        const SizedBox(height: 32),

        /// PHONE IMAGE
        Image.asset(
          phoneImage,
          height: 320,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}

/* =========================
   SHARED CONTENT
========================= */
class _Content extends StatelessWidget {
  const _Content({
    required this.title,
    required this.description,
    required this.onGooglePlayTap,
    required this.onAppStoreTap,
    this.centerText = false,
  });

  final String title;
  final String description;
  final VoidCallback onGooglePlayTap;
  final VoidCallback onAppStoreTap;
  final bool centerText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      centerText ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: centerText ? TextAlign.center : TextAlign.start,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          description,
          textAlign: centerText ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: 15,
            color: Colors.white.withOpacity(0.9),
            height: 1.7,
          ),
        ),
        const SizedBox(height: 28),

        /// STORE BUTTONS
        Wrap(
          alignment:
          centerText ? WrapAlignment.center : WrapAlignment.start,
          spacing: 16,
          runSpacing: 12,
          children: [
            StoreButton(
              onTap: onGooglePlayTap,
              background: Colors.black,
              icon: AssetsManager.googlePlay,
              smallText: AppLocalizations.of(context)!.storeGetItOn,
              title: 'Google Play',
              textColor: Colors.white,
            ),
            StoreButton(
              onTap: onAppStoreTap,
              background: Colors.white,
              icon: AssetsManager.appStore,
              smallText: AppLocalizations.of(context)!.storeDownloadOn,
              title: 'App Store',
              textColor: Colors.black,
            ),
          ],
        ),
      ],
    );
  }
}

/* =========================
   STORE BUTTON
========================= */
class StoreButton extends StatelessWidget {
  const StoreButton({
    super.key,
    required this.onTap,
    required this.background,
    required this.icon,
    required this.smallText,
    required this.title,
    required this.textColor,
  });

  final VoidCallback onTap;
  final Color background;
  final String icon;
  final String smallText;
  final String title;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(icon, height: 22, color: background == Colors.white ? Colors.black : null),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  smallText,
                  style: TextStyle(fontSize: 10, color: textColor.withOpacity(.7)),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
