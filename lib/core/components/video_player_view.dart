import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerView({super.key, required this.videoUrl});

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _controller;
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    )..initialize().then((_) {
      setState(() {});
      _controller.play();
    });

    _controller.addListener(_videoListener);
  }

  void _videoListener() {
    final value = _controller.value;

    if (!value.isInitialized) return;

    /// 🟢 ده المهم
    setState(() {});

    if (value.duration != Duration.zero &&
        value.position >= value.duration &&
        !_isFinished) {
      _isFinished = true;
    }

    if (value.isPlaying && _isFinished) {
      _isFinished = false;
    }
  }


  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _togglePlay() {
    setState(() {
      if (_isFinished) {
        _controller.seekTo(Duration.zero);
        _controller.play();
        _isFinished = false;
      } else {
        _controller.value.isPlaying
            ? _controller.pause()
            : _controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme:   IconThemeData(color: Colors.white,size:  24),
      ),
      body: _controller.value.isInitialized
          ? Column(
        children: [
          /// 🎥 الفيديو
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
          ),

          /// 🎛 Controls
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    playedColor: Colors.red,
                    bufferedColor: Colors.white24,
                    backgroundColor: Colors.white12,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(_controller.value.position),
                      style:   TextStyle(color: Colors.white, fontSize:  16),
                    ),
                    Text(
                      _formatDuration(_controller.value.duration),
                      style: const TextStyle(color: Colors.white , fontSize:  16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      )
          : const Center(child: CircularProgressIndicator()),


      /// ================= Play / Pause =================
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: _togglePlay,
        child: Icon(
          _isFinished
              ? Icons.replay
              : _controller.value.isPlaying
              ? Icons.pause
              : Icons.play_arrow,
          color: Colors.black,
        ),
      ),
    );
  }
}
