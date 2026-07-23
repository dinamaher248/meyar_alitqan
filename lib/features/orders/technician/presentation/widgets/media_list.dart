import 'package:flutter/material.dart';
import 'package:meayar_alitqan/core/components/video_player_view.dart';
import 'package:meayar_alitqan/core/components/full_screen_image_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/helper/responsive_size.dart';
import '../../../../../core/helper/video_thumbnail_box.dart';
import '../../../../../core/utils/colors_manager.dart';

class MediaList extends StatelessWidget {
  const MediaList({
    super.key,
    required this.urls,
    this.isVideo = false,
  });

  final List<String> urls;
  final bool isVideo;

  @override
  Widget build(BuildContext context) {
    if (urls.isEmpty) {
      return const _MediaPlaceholder();
    }

    return SizedBox(
      height: RS.size(context, 100),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: urls.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final mediaUrl =
          isVideo ? _videoPublicUrl(urls[index]) : urls[index];

          final heroTag = '${mediaUrl}_$index';

          return GestureDetector(
            onTap: () {
              if (isVideo) {
                /// ▶️ VIDEO
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VideoPlayerView(videoUrl: mediaUrl),
                  ),
                );
              } else {
                /// 🖼 IMAGE
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FullScreenImageView(
                      imageUrl: mediaUrl,
                      heroTag: heroTag,
                    ),
                  ),
                );
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(RS.radius(context, 10)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Hero(
                    tag: heroTag,
                    child: Container(
                      width: RS.size(context, 120),
                      color: ColorsManager.grey,
                      child: isVideo
                          ? VideoThumbnailBox(
                        videoUrl: mediaUrl,
                        size: 100,
                        width: 160,
                      )
                          : Image.network(
                        mediaUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  /// ▶️ Play icon (videos only)
                  if (isVideo)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

String _videoPublicUrl(String path) {
  return Supabase.instance.client.storage
      .from('service-videos')
      .getPublicUrl(path);
}

class _MediaPlaceholder extends StatelessWidget {
  const _MediaPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: RS.size(context, 100),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorsManager.grey,
        borderRadius: BorderRadius.circular(RS.radius(context, 10)),
      ),
    );
  }
}
