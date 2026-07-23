import 'dart:io';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

Future<File?> generateVideoThumbnail(File video) async {
  final dir = await getTemporaryDirectory();

  final thumbnailPath = await VideoThumbnail.thumbnailFile(
    video: video.path,
    thumbnailPath: dir.path,
    imageFormat: ImageFormat.JPEG,
    maxHeight: 300,
    quality: 75,
  );

  if (thumbnailPath == null) return null;
  return File(thumbnailPath);
}
