import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/services/whatsapp_service.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../core/helper/responsive_size.dart';
import '../../../../../../../core/utils/assets_manager.dart';
import '../../../../../../../core/utils/colors_manager.dart';

class ContactUsViewBody extends StatelessWidget {
  const ContactUsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: EdgeInsets.all(RS.size(context, 16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: RS.size(context, 16)),

          /// ===== Logo + Location =====
          Center(
            child: Image.asset(
              AssetsManager.logo,
              height: RS.size(context, 170),
            ),
          ),
          SizedBox(height: RS.size(context, 16)),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: RS.size(context, 20),
                color: ColorsManager.primaryColor,
              ),

              SizedBox(width: RS.size(context, 4)),
               Text(
                t.ourMainLocation,
                style: TextStyle(
                  fontSize: RS.font(context, 16),
                  fontWeight: FontWeight.w400,
                  color: ColorsManager.darkGrey,
                ),
              ),
                            SizedBox(width: RS.size(context, 4)),

              Text(
                t.contact_location,
                style: TextStyle(
                  fontSize: RS.font(context, 16),
                                    fontWeight: FontWeight.w500,

                  color: ColorsManager.primaryColor,
                ),
              ),
            ],
          ),

          SizedBox(height: RS.size(context, 39)),

          Text(
            t.contact_info_description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: RS.font(context, 16),
              fontWeight: FontWeight.w500,
              color: ColorsManager.darkGrey,
            ),
          ),

          SizedBox(height: RS.size(context, 24)),
  Text(
            t.youCanContactUsBy,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: RS.font(context, 16),
              fontWeight: FontWeight.w500,
              color: ColorsManager.darkGrey,
            ),
          ),
          /// ===== WhatsApp =====
          _buildContactRow(
            context,
            iconPath: AssetsManager.whatsapp,
            title: t.contact_whatsapp_title,
            subtitle: t.contact_whatsapp_number,
            onTap: () {
              WhatsAppService.openChat(phone: "+962781319003", message: "");
            },
          ),

          SizedBox(height: RS.size(context, 12)),

          /// ===== Email =====
          _buildContactRow(
            context,
            icon: Icons.email_outlined,
            title: t.contact_email_title,
            subtitle: t.contact_email_address,
            onTap: () async {
              final Uri emailUri = Uri(
                scheme: 'mailto',
                path: t.contact_email_address,
              );
              if (await canLaunchUrl(emailUri)) {
                await launchUrl(emailUri);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(
    BuildContext context, {
    String? iconPath,
    IconData? icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(RS.radius(context, 10)),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: RS.size(context, 12),
          vertical: RS.size(context, 12),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(RS.radius(context, 10)),
          border: Border.all(color: ColorsManager.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  iconPath != null
                      ? Image.asset(
                          iconPath,
                          width: RS.size(context, 22),
                          height: RS.size(context, 22),
                        )
                      : Icon(icon, size: RS.size(context, 22)),
                                 SizedBox(width: RS.size(context, 12)),

                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: RS.font(context, 18),
                              color: ColorsManager.primaryColor,
                            ),
                      ),
                      SizedBox(height: RS.size(context, 2)),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: RS.font(context, 14),
                          fontWeight: FontWeight.w500,
                          color: ColorsManager.darkGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: ColorsManager.primaryColor,
              size: RS.size(context, 18),
            ),
          ],
        ),
      ),
    );
  }
}
