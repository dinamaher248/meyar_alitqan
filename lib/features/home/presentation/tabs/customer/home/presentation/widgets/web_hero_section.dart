import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../../../core/services/whatsapp_service.dart';
import '../../../../../../../../core/utils/assets_manager.dart';
import '../../../../../../../../core/utils/colors_manager.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class WebHeroSection extends StatelessWidget {
  const WebHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 56),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorsManager.primaryColor.withOpacity(0.9),
            ColorsManager.primaryColor,
             
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// ================= TEXT =================
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    loc.appName, // معيار الإتقان
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 40
                        ),
                  ),
      
                  const SizedBox(height: 12),
      
                  Text(
                    loc.webHeroSubtitle,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                          height: 1.6,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),

                    maxLines: 3,
                  ),
      
        
       
                ],
              ),
            ),
      
            if (width >= 1000) ...[
              const SizedBox(width: 48),
              Expanded(
                flex: 4,
                child: SvgPicture.asset(
                  AssetsManager.onBoardingImage1,
                  height: 260,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

