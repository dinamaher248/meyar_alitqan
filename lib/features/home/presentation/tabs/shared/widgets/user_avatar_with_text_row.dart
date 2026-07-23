import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meayar_alitqan/features/home/presentation/tabs/shared/widgets/fall_back_avatar.dart';

import '../../../../../../core/helper/responsive_size.dart';
import '../../../../../../core/utils/colors_manager.dart';
import '../../../../../../l10n/app_localizations.dart';

class UserAvatarWithTextRow extends StatelessWidget {
  const UserAvatarWithTextRow({
    super.key,
    this.name,
    this.role,
    required this.avatar,
    this.showImageOnly = false,
  });

  final String? name;
  final String? role;
  final String avatar;
  final bool showImageOnly;

  @override
  Widget build(BuildContext context) {
    final avatarUrl = avatar.isNotEmpty
        ? '$avatar?t=${DateTime.now().millisecondsSinceEpoch}'
        : avatar;
    final isWeb = MediaQuery.of(context).size.width > 900;
    final avatarSize = isWeb ? 50.0 : RS.size(context, 44);

    return Row(
      children: [

        CachedNetworkImage(
          imageUrl: avatarUrl,
          imageBuilder: (context, imageProvider) => Container(
            width: avatarSize,
            height: avatarSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          placeholder: (_, __) => SizedBox(
            width: avatarSize,
            height: avatarSize,
            child: const CircularProgressIndicator(strokeWidth: 2),
          ),
          errorWidget: (_, __, ___) =>
              fallbackAvatar(context, avatarSize, name ?? ''),
        ),
         SizedBox(width: RS.size(context, 10)),

        if (!showImageOnly)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name ?? AppLocalizations.of(context)!.guest,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: RS.font(context, 16),
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.primaryTextDarkColor,
                ),
              ),
              SizedBox(height: RS.size(context, 2)),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: RS.size(context, 14),
                    color: ColorsManager.secondaryTextDarkColor,
                  ),
                  SizedBox(width: RS.size(context, 2)),
                  Text(
                    role ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: RS.font(context, 12),
                      color: ColorsManager.secondaryTextDarkColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

       
      ],
    );
  }
}