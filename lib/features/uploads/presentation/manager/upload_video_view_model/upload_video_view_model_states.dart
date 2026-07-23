import 'dart:io';

import '../../../domain/entities/upload_result_entity/upload_result_entity.dart';

abstract class UploadVideoViewModelStates {}

class UploadVideoViewModelInitial extends UploadVideoViewModelStates {}

class UploadVideoViewModelLoading extends UploadVideoViewModelStates {
  final double progress; // 0 → 1
  UploadVideoViewModelLoading(this.progress);
}
class UploadVideoViewModelSuccess extends UploadVideoViewModelStates {
  final UploadResultEntity result;
  final File ?thumbnail;
  final bool isPlaying;

  UploadVideoViewModelSuccess({
    required this.result,
    required this.thumbnail,
    this.isPlaying = false,
  });

  UploadVideoViewModelSuccess copyWith({bool? isPlaying}) {
    return UploadVideoViewModelSuccess(
      result: result,
      thumbnail: thumbnail,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}


class UploadVideoViewModelError extends UploadVideoViewModelStates {
  final String message;
  UploadVideoViewModelError(this.message);
}
