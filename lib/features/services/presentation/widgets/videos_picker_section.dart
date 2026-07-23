import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../uploads/presentation/manager/upload_video_view_model/upload_video_view_model.dart';
import '../../../uploads/presentation/manager/upload_video_view_model/upload_video_view_model_states.dart';
import '../widgets/video_container.dart';

class VideosPickerSection extends StatefulWidget {
  const VideosPickerSection({super.key});

  @override
  State<VideosPickerSection> createState() => _VideosPickerSectionState();
}

class _VideosPickerSectionState extends State<VideosPickerSection> {
  VideoPlayerController? _controller;
  bool _isInitializing = false;

  // ================== Lifecycle ==================
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  // ================== Video Player ==================
  Future<void> _initAndPlayVideo(String url) async {
    if (url.isEmpty) return;

    final uri = Uri.tryParse(url);
    if (uri == null || !uri.isAbsolute) return;

    if (_isInitializing) return;
    _isInitializing = true;

    try {
      await _controller?.dispose();

      _controller = VideoPlayerController.networkUrl(uri);
      await _controller!.initialize();
      await _controller!.setLooping(true);
      await _controller!.play();
    } catch (_) {
      await _controller?.dispose();
      _controller = null;
    }

    _isInitializing = false;
    if (mounted) setState(() {});
  }

  // ================== UI ==================
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.addVideosForYourProblem,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: RS.font(context, 16),
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: RS.size(context, 10)),

        BlocBuilder<UploadVideoViewModel, UploadVideoViewModelStates>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () => _onPickVideo(context, state),
              child: VideoContainer(
                state: state,
                controller: _controller,
                onPlay: _initAndPlayVideo,
              ),
            );
          },
        ),
      ],
    );
  }

  // ================== Pick Video ==================
  Future<void> _onPickVideo(
    BuildContext context,
    UploadVideoViewModelStates state,
  ) async {
    if (state is UploadVideoViewModelLoading ||
        state is UploadVideoViewModelSuccess) {
      return;
    }

    final picker = ImagePicker();
    final picked = await picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(minutes: 10),
    );

    if (picked == null) return;

    final vm = context.read<UploadVideoViewModel>();

    if (kIsWeb) {
      // 🌐 Web → XFile (bytes)
      vm.uploadVideoWeb(picked);
    } else {
      // 📱 Mobile → File
      vm.uploadVideoMobile(File(picked.path));
    }
  }
}
