import 'package:flutter/cupertino.dart';
import 'package:meayar_alitqan/config/routes/routes_manager.dart';
import 'package:meayar_alitqan/features/orders/customer/presentation/widgets/section_title.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/helper/responsive_size.dart';
import '../../../../../core/helper/video_thumbnail_box.dart';
import '../../../../../l10n/app_localizations.dart';
import 'media_box.dart';

class OrderMediaSection extends StatelessWidget {
  const OrderMediaSection({
    super.key,
    required this.photos,
    required this.videos,
  });

  final List<String> photos;
  final List<String> videos;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Column(
      children: [
        /// 📸 الصور
        if (photos.isNotEmpty) ...[
          SectionTitle(title: t.uploadedPhotos),
          SizedBox(height: RS.size(context, 10)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                photos.length,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: RS.size(context, 5),
                  ),
                  child:GestureDetector(
  onTap: () {
    Navigator.pushNamed(
      context,
      RoutesManager.fullScreenImage,
      arguments: {
        'imageUrl': photos[index],
        'heroTag': photos[index],  
      },
    );
  },
  child: Hero(
    tag: photos[index],   
    child: MediaBox(
      size: 50,
      image: photos[index],
    ),
  ),
),

                ),
              ),
            ),
          ),
        ],

        /// 🎥 الفيديوهات
        if (videos.isNotEmpty) ...[
          SizedBox(height: RS.size(context, 16)),
          SectionTitle(title: t.uploadedVideos),
          SizedBox(height: RS.size(context, 10)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                videos.length,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: RS.size(context, 5),
                  ),
                  child: VideoThumbnailBox(
                    videoUrl: _videoPublicUrl(videos[index]),
                    size: 100,
                    width: 160,

                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  String _videoPublicUrl(String path) {
    return Supabase.instance.client.storage
        .from('service-videos')
        .getPublicUrl(path);
  }
}

