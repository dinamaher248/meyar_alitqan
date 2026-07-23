import 'package:flutter/material.dart';

import '../../../../../core/helper/responsive_size.dart';
import '../../../../../core/utils/colors_manager.dart';
class MediaBox extends StatelessWidget {
  final double size;
  final double? width;
  final String? image;
  final bool isVideo;
  final VoidCallback? onTap;

  const MediaBox({
    super.key,
    required this.size,
    this.width,
    this.image,
    this.isVideo = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: RS.size(context, size),
        width: width != null ? RS.size(context, width!) : RS.size(context, size),
        decoration: BoxDecoration(
          image: image != null && !isVideo
              ? DecorationImage(
            image: NetworkImage(image!),
            fit: BoxFit.cover,
          )
              : null,
          color: ColorsManager.primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(
            RS.radius(context, 10),
          ),
        ),
        child: isVideo
            ? Center(
          child: Icon(
            Icons.play_circle_fill,
            size: RS.size(context, 36),
            color: Colors.white,
          ),
        )
            : null,
      ),
    );
  }
}
