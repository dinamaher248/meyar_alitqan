
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoThumbnailBox extends StatefulWidget {
  final String videoUrl;
  final double size;
  final double? width;

  const VideoThumbnailBox({
    super.key,
    required this.videoUrl,
    required this.size,
    this.width,
  });

  @override
  State<VideoThumbnailBox> createState() => _VideoThumbnailBoxState();
}

class _VideoThumbnailBoxState extends State<VideoThumbnailBox> {
  VideoPlayerController? _controller;
  Uint8List? _thumbnail;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    // ❌ Web: مفيش thumbnail
    if (!kIsWeb) {
      _loadThumbnail();
    }
  }

  // ================== Thumbnail (Mobile only) ==================
  Future<void> _loadThumbnail() async {
    try {
      final thumb = await VideoThumbnail.thumbnailData(
        video: widget.videoUrl,
        imageFormat: ImageFormat.JPEG,
        quality: 70,
      );

      if (mounted) {
        setState(() => _thumbnail = thumb);
      }
    } catch (_) {
      // ignore thumbnail errors
    }
  }

  // ================== Play / Pause ==================
  Future<void> _togglePlay() async {
    if (_controller == null) {
      _controller =
          VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
      await _controller!.initialize();
      await _controller!.play();
      setState(() => isPlaying = true);
    } else {
      if (_controller!.value.isPlaying) {
        await _controller!.pause();
        setState(() => isPlaying = false);
      } else {
        await _controller!.play();
        setState(() => isPlaying = true);
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  // ================== UI ==================
  @override
  Widget build(BuildContext context) {
    final h = widget.size;
    final w = widget.width ?? h;

    return GestureDetector(
      onTap: _togglePlay,
      child: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black12,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: _controller != null && _controller!.value.isInitialized
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    VideoPlayer(_controller!),
                    if (!isPlaying) _playIcon(),
                  ],
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    _buildPreview(w, h),
                    _playIcon(),
                  ],
                ),
        ),
      ),
    );
  }

  // ================== Preview ==================
  Widget _buildPreview(double w, double h) {
    // 🌐 Web → placeholder
    if (kIsWeb) {
      return Container(
        width: w,
        height: h,
        color: Colors.black26,
      );
    }

    // 📱 Mobile → thumbnail
    if (_thumbnail != null) {
      return Image.memory(
        _thumbnail!,
        fit: BoxFit.cover,
        width: w,
        height: h,
      );
    }

    return Container(
      width: w,
      height: h,
      color: Colors.black26,
    );
  }

  Widget _playIcon() => const Icon(
        Icons.play_circle_fill,
        size: 40,
        color: Colors.white,
      );
}
