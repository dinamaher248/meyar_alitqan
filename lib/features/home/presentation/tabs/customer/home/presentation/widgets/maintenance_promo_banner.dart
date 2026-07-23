import 'package:flutter/material.dart';

import '../../../../../../../../core/helper/responsive_size.dart';
import '../../../../../../../../core/services/whatsapp_service.dart';
import '../../../../../../../../core/utils/assets_manager.dart';
import '../../../../../../../../core/utils/colors_manager.dart';
import '../../../../../../../../l10n/app_localizations.dart';

class MaintenancePromoBanner extends StatelessWidget {
  const MaintenancePromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () {
        WhatsAppService.openChat(
          phone: "+962781319003",
          message: "مرحبًا، حابب أستفسر عن عروض الصيانه",
        );
      },
      child: Container(
        height: RS.size(context, 180),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: ColorsManager.primaryColor,
          borderRadius: BorderRadius.circular(RS.radius(context, 16)),
        ),
        child: Stack(
          children: [
            /// ===== Decorative circle (bottom-left) =====
            Positioned(
              bottom: -RS.size(context, 40),
              left: -RS.size(context, 30),
              child: Container(
                width: RS.size(context, 100),
                height: RS.size(context, 100),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
            ),

            /// ===== Worker Image (left side, full height) =====
            Positioned(
              left: 0,
              bottom: 0,
              child: Image.asset(
                AssetsManager.maintenanceWorker,
                fit: BoxFit.cover,
                height: RS.size(context, 180),
              ),
            ),

            /// ===== Text + Button (overlaid on the right) =====
            Positioned.fill(
              left: RS.size(context, 220),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: RS.size(context, 16),
                  horizontal: RS.size(context, 20),
                ),
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        loc.maintenanceBannerTitle,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: RS.font(context, 18),
                          fontWeight: FontWeight.w500,
                          color: ColorsManager.white,
                        ),
                      ),

                      SizedBox(height: RS.size(context, 8)),

                      Text(
                        loc.maintenanceBannerDescription,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: RS.font(context, 14),
                          fontWeight: FontWeight.w400,
                          color: ColorsManager.primaryTextLightColor,
                          height: 1.4,
                        ),
                      ),

                      SizedBox(height: RS.size(context, 14)),

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: RS.size(context, 20),
                          vertical: RS.size(context, 9),
                        ),
                        decoration: BoxDecoration(
                          color: ColorsManager.secondaryColor,
                          borderRadius: BorderRadius.circular(
                            RS.radius(context, 5),
                          ),
                        ),
                        child: Text(
                          loc.bookNow,
                          style: TextStyle(
                            fontSize: RS.font(context, 14),
                            fontWeight: FontWeight.w500,
                            color: ColorsManager.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}