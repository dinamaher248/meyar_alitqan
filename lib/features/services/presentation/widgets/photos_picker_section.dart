import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/colors_manager.dart';
import '../../../uploads/presentation/manager/upload_images_view_model/upload_images_view_model.dart';
import '../../../uploads/presentation/manager/upload_images_view_model/upload_images_view_model_states.dart';
import 'dashed_border_painter.dart';

class PhotosPickerSection extends StatefulWidget {
  const PhotosPickerSection({super.key});

  @override
  State<PhotosPickerSection> createState() => _PhotosPickerSectionState();
}

class _PhotosPickerSectionState extends State<PhotosPickerSection> {
  final List<XFile> _images = [];

  Future<void> _pickImages(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles.isEmpty) return;

    setState(() {
      _images.addAll(pickedFiles);
    });

    context.read<UploadImagesViewModel>().uploadImages(pickedFiles);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.addVideosForYourProblem == t.addVideosForYourProblem
              ? t.addMedia
              : t.addPhotosForYourProblem,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: RS.font(context, 16),
            fontWeight: FontWeight.w500,
            color: ColorsManager.primaryTextDarkColor,
          ),
        ),
        SizedBox(height: RS.size(context, 18)),

        BlocBuilder<UploadImagesViewModel, UploadImagesViewModelStates>(
          builder: (context, state) {
            return Wrap(
              spacing: RS.size(context, 10),
              runSpacing: RS.size(context, 10),
              children: [
                ..._images.map((file) => _buildThumbnail(file)),
                _AddPhotoTile(
                  isLoading: state is UploadImagesViewModelLoading,
                  onTap: () => _pickImages(context),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildThumbnail(XFile file) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: kIsWeb
              ? Image.network(
                  file.path,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                )
              : Image.file(
                  File(file.path),
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _images.remove(file);
              });
            },
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 12, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class _AddPhotoTile extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLoading;

  const _AddPhotoTile({required this.onTap, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: CustomPaint(
        painter: DashedBorderPainter(color: ColorsManager.darkGrey, radius: 10),
        child: Container(
          width: RS.size(context, 85),
          height: RS.size(context, 79),
          decoration: BoxDecoration(
            color: ColorsManager.lightGrey.withOpacity(0.2), 
            borderRadius: BorderRadius.circular(10),
          ),
          child: isLoading
              ? const Padding(
                  padding: EdgeInsets.all(14),
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(Icons.add, size: RS.size(context, 24), color: ColorsManager.darkGrey),
        ),
      ),
    );
  }
}
