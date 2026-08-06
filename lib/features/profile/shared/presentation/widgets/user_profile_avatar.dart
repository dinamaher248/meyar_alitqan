import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/helper/responsive_size.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/utils/colors_manager.dart';

class UserProfileAvatar extends StatelessWidget {
  const UserProfileAvatar({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.onChange,
    this.isEdit,
    this.email,
    this.rating,
  });

  final String? imageUrl;
  final String? name;
  final String? email;
  final double? rating;
  final VoidCallback onChange;
  final bool? isEdit;

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;
    final firstLetter = (name != null && name!.isNotEmpty) ? name![0] : '?';
    final imageWithCacheBuster = hasImage
        ? '${imageUrl!}?t=${DateTime.now().millisecondsSinceEpoch}'
        : null;

    final avatarWidget = GestureDetector(
      onTap: onChange,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(

            width: RS.size(context, 100),
            height: RS.size(context, 100),
            child: ClipOval(
              child: hasImage
                  ? CachedNetworkImage(
                      imageUrl: imageWithCacheBuster!,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => const CircularProgressIndicator(),
                      errorWidget: (_, __, ___) =>
                          _fallbackAvatar(context, firstLetter),
                    )
                  : _fallbackAvatar(context, firstLetter),
            ),
          ),
          Positioned(
            bottom: -2,
            left: -2,
            child: Container(
              padding: EdgeInsets.all(RS.size(context, 5)),
              decoration: BoxDecoration(
                color: ColorsManager.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(
                CupertinoIcons.camera,
                color: ColorsManager.primaryColor,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );

    if (isEdit == true) {
      return SizedBox(
        width: double.infinity,
        child: Center(child: avatarWidget),
      );
    }

    return Row(
      children: [
        avatarWidget,
        SizedBox(width: RS.size(context, 12)),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name ?? '',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: RS.font(context, 20),
                  fontWeight: FontWeight.w500,
                  color: ColorsManager.black,
                ),
              ),

              if (email != null && email!.isNotEmpty) ...[
                SizedBox(height: RS.size(context, 2)),
                Text(
                  email!,
                  style: TextStyle(
                    fontSize: RS.font(context, 14),
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.darkGrey,
                  ),
                ),
              ],

              if (rating != null && rating! > 0) ...[
                SizedBox(height: RS.size(context, 4)),
                Row(
                  children: [
                    SvgPicture.asset(
                      AssetsManager.star,
                      width: RS.size(context, 14),
                      height: RS.size(context, 14),
                    ),
                    SizedBox(width: RS.size(context, 4)),
                    Text(
                      rating!.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: RS.font(context, 14),
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.primaryTextDarkColor,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _fallbackAvatar(BuildContext context, String letter) {
    return Container(
      color: ColorsManager.primaryColor.withValues(alpha: 0.4),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontSize: RS.font(context, 20),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
