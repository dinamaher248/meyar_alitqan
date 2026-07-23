import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/uploads/domain/use_cases/upload_video_use_case/upload_video_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/helper/generate_video_thumbnail.dart';
import 'upload_video_view_model_states.dart';

@injectable
class UploadVideoViewModel extends Cubit<UploadVideoViewModelStates> {
  final UploadVideoUseCase uploadVideoUseCase;

  UploadVideoViewModel(this.uploadVideoUseCase)
      : super(UploadVideoViewModelInitial());

  // ===================== 📱 MOBILE =====================
  Future<void> uploadVideoMobile(File video) async {
    try {
      emit(UploadVideoViewModelLoading(0));

      /// ✅ Thumbnail (Mobile only)
      final thumbnail = await generateVideoThumbnail(video);

      final result = await uploadVideoUseCase.uploadVideoMobile(
        video,
        onProgress: (progress) {
          emit(UploadVideoViewModelLoading(progress));
        },
      );

      result.fold(
        (failure) =>
            emit(UploadVideoViewModelError(failure.message)),
        (uploadResult) {
          final publicUrl = _buildPublicUrl(uploadResult.path.last);

          emit(
            UploadVideoViewModelSuccess(
              result:
                  uploadResult.copyWith(publicUrl: publicUrl),
              thumbnail: thumbnail!,
            ),
          );
        },
      );
    } catch (e) {
      emit(UploadVideoViewModelError(e.toString()));
    }
  }

  // ===================== 🌐 WEB =====================
  Future<void> uploadVideoWeb(XFile video) async {
    try {
      emit(UploadVideoViewModelLoading(0));

      final bytes = await video.readAsBytes();

      final result = await uploadVideoUseCase.uploadVideoWeb(
        bytes,
        onProgress: (progress) {
          emit(UploadVideoViewModelLoading(progress));
        },
      );

      result.fold(
        (failure) =>
            emit(UploadVideoViewModelError(failure.message)),
        (uploadResult) {
          final publicUrl = _buildPublicUrl(uploadResult.path.last);

          emit(
            UploadVideoViewModelSuccess(
              result:
                  uploadResult.copyWith(publicUrl: publicUrl),
              thumbnail: null, // ❌ no thumbnail on Web
            ),
          );
        },
      );
    } catch (e) {
      emit(UploadVideoViewModelError(e.toString()));
    }
  }

  // ===================== HELPERS =====================
  String _buildPublicUrl(String fileName) {
    final supabase = Supabase.instance.client;
    return supabase.storage
        .from('service-videos')
        .getPublicUrl(fileName);
  }
}
