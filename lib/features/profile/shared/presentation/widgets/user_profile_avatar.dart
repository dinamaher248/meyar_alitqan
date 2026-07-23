import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meayar_alitqan/core/helper/responsive_size.dart';
import 'package:meayar_alitqan/core/utils/colors_manager.dart';

import '../../../../../core/utils/assets_manager.dart';

class UserProfileAvatar extends StatelessWidget {
  const UserProfileAvatar({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.onChange,
    this.rating,
  });

  final String? imageUrl;
  final String? name;
  final double? rating;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;
    final firstLetter = (name != null && name!.isNotEmpty) ? name![0] : '?';
    final imageWithCacheBuster = hasImage
        ? '${imageUrl!}?t=${DateTime.now().millisecondsSinceEpoch}'
        : null;

    return Container(
      padding: EdgeInsets.symmetric(vertical: RS.size(context, 16)),
      width: double.infinity,
      color: ColorsManager.primaryColor.withOpacity(.1),
      child: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: onChange,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: RS.size(context, 80),
                    height: RS.size(context, 80),
                    child: ClipOval(
                      child: hasImage
                          ? CachedNetworkImage(
                              imageUrl: imageWithCacheBuster!,
                              fit: BoxFit.cover,
                              placeholder: (_, __) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (_, __, ___) =>
                                  _fallbackAvatar(context, firstLetter),
                            )
                          : _fallbackAvatar(context, firstLetter),
                    ),
                  ),

                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      padding: EdgeInsets.all(RS.size(context, 6)),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        CupertinoIcons.camera,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: RS.size(context, 8)),

            Text(
              name != null ? '($name)' : '',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: RS.font(context, 18),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: RS.size(context, 8)),
            if (rating != null && rating! > 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetsManager.star,
                    width: RS.size(context, 14),
                    height: RS.size(context, 14),
                  ),
                  SizedBox(width: RS.size(context, 4)),
                  Text(
                    rating != null ? rating!.toStringAsFixed(1) : '',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: RS.font(context, 16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _fallbackAvatar(BuildContext context, String letter) {
    return Container(
      color: ColorsManager.primaryColor.withOpacity(0.4),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontSize: RS.font(context, 24),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
