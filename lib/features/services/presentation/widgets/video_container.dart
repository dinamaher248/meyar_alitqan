
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/colors_manager.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../uploads/presentation/manager/upload_video_view_model/upload_video_view_model_states.dart';

class VideoContainer extends StatelessWidget {
  final UploadVideoViewModelStates state;
  final VideoPlayerController? controller;
  final Future<void> Function(String url) onPlay;

  const VideoContainer({super.key, 
    required this.state,
    required this.controller,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(RS.radius(context, 10)),
        border: Border.all(color: _borderColor(state), width: 2),
      ),
      child: _buildContent(context, t),
    );
  }

  Color _borderColor(UploadVideoViewModelStates state) {
    if (state is UploadVideoViewModelError) return Colors.red;
    if (state is UploadVideoViewModelSuccess) {
      return ColorsManager.primaryColor;
    }
    return ColorsManager.grey;
  }

  Widget _buildContent(BuildContext context, AppLocalizations t) {
    if (state is UploadVideoViewModelLoading) {
      return _UploadingView(state as UploadVideoViewModelLoading);
    }

    if (state is UploadVideoViewModelSuccess) {
      return _VideoPreview(
        state: state as UploadVideoViewModelSuccess,
        controller: controller,
        onPlay: onPlay,
      );
    }

    if (state is UploadVideoViewModelError) {
      return _ErrorView((state as UploadVideoViewModelError).message);
    }

    return _InitialView();
  }
}

class _InitialView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AssetsManager.video,
            width: RS.size(context, 28),
            height: RS.size(context, 28),
          ),
          SizedBox(height: RS.size(context, 8)),
          Text(
            t.maximumOneVideo,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: RS.font(context, 14),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView(this.message);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 32),
          SizedBox(height: RS.size(context, 6)),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.red, fontWeight: FontWeight.bold , fontSize: RS.font(context, 14)),
          ),
        ],
      ),
    );
  }
}

class _UploadingView extends StatelessWidget {
  final UploadVideoViewModelLoading state;

  const _UploadingView(this.state);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(AssetsManager.upload, height: RS.size(context, 100)),
          SizedBox(height: RS.size(context, 8)),
          Text(
            t.uploadingWithProgress((state.progress * 100).toStringAsFixed(0)),
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: RS.font(context, 16))
          ),
          SizedBox(height: RS.size(context, 8)),
          Text(
            t.uploadingVideoHint,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: RS.font(context, 14))
          ),
        ],
      ),
    );
  }
}

class _VideoPreview extends StatelessWidget {
  final UploadVideoViewModelSuccess state;
  final VideoPlayerController? controller;
  final Future<void> Function(String url) onPlay;

  const _VideoPreview({
    required this.state,
    required this.controller,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    final isReady = controller != null && controller!.value.isInitialized;
    final videoUrl = state.result.publicUrl ?? '';

    return GestureDetector(
      onTap: () async {
        if (!isReady) {
          await onPlay(videoUrl);
        } else {
          controller!.value.isPlaying
              ? await controller!.pause()
              : await controller!.play();
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(RS.radius(context, 10)),
            child: isReady
                ? AspectRatio(
                    aspectRatio: controller!.value.aspectRatio,
                    child: VideoPlayer(controller!),
                  )
                : _buildPreview(context, videoUrl),
          ),

          /// ▶️ / ⏸ Overlay
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(RS.size(context, 12)),
            child: Icon(
              isReady && controller!.value.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
              color: Colors.white,
              size: RS.size(context, 36),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= PREVIEW =================
  Widget _buildPreview(BuildContext context, String videoUrl) {
    // 🌐 Web → مفيش Image.file
    if (kIsWeb) {
      return Container(
        width: double.infinity,
        height: RS.size(context, 200),
        color: Colors.black12,
        alignment: Alignment.center,
        child: const Icon(
          Icons.play_circle_outline,
          size: 64,
          color: Colors.black45,
        ),
      );
    }

    // 📱 Mobile → Thumbnail
    if (state.thumbnail != null) {
      return Image.file(
        state.thumbnail!,
        width: double.infinity,
        height: RS.size(context, 200),
        fit: BoxFit.cover,
      );
    }

    // fallback
    return Container(
      width: double.infinity,
      height: RS.size(context, 200),
      color: Colors.black12,
    );
  }
}

