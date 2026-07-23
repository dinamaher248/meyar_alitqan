import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meayar_alitqan/l10n/app_localizations.dart';

import '../../../../core/helper/responsive_size.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/colors_manager.dart';
import '../../../uploads/presentation/manager/upload_images_view_model/upload_images_view_model.dart';
import '../../../uploads/presentation/manager/upload_images_view_model/upload_images_view_model_states.dart';

class PhotosPickerSection extends StatefulWidget {
  const PhotosPickerSection({super.key});

  @override
  State<PhotosPickerSection> createState() => _PhotosPickerSectionState();
}

class _PhotosPickerSectionState extends State<PhotosPickerSection> {
  /// ✅ استخدم XFile بدل File
  final List<XFile> _images = [];

  Future<void> _pickImages(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles.isEmpty) return;

    setState(() {
      _images.addAll(pickedFiles);
    });

    /// ViewModel يستقبل XFile (أفضل للويب والموبايل)
    context.read<UploadImagesViewModel>().uploadImages(pickedFiles);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.addPhotosForYourProblem,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: RS.font(context, 16),
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: RS.size(context, 8)),

        /// 🔢 Counter
        if (_images.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              t.photosCount(_images.length),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
            
                    fontWeight: FontWeight.bold,
                    fontSize: RS.font(context, 12),
                  ),
            ),
          ),

        BlocBuilder<UploadImagesViewModel, UploadImagesViewModelStates>(
          builder: (context, state) {
            return GestureDetector(
              onTap: _images.isEmpty && state is! UploadImagesViewModelLoading
                  ? () => _pickImages(context)
                  : null,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(RS.size(context, 12)),
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  borderRadius: BorderRadius.circular(RS.radius(context, 10)),
                  border: Border.all(color: _borderColor(state), width: 2),
                ),
                child: _images.isEmpty
                    ? _InitialPhotosView(context)
                    : _buildGrid(context, state),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _InitialPhotosView(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return SizedBox(
      height: RS.size(context, 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AssetsManager.photo,
            width: RS.size(context, 24),
            height: RS.size(context, 24),
          ),
          SizedBox(height: RS.size(context, 16)),
          Text(
            t.addPhotosForYourProblem,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: RS.font(context, 16),
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Color _borderColor(UploadImagesViewModelStates state) {
    if (state is UploadImagesViewModelError) return Colors.red;
    if (state is UploadImagesViewModelSuccess) {
      return ColorsManager.primaryColor;
    }
    return ColorsManager.grey;
  }

  Widget _buildGrid(BuildContext context, UploadImagesViewModelStates state) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        /// ➕ Add Button
        _AddPhotoTile(
          isLoading: state is UploadImagesViewModelLoading,
          onTap: () => _pickImages(context),
        ),

        /// 🖼 Images
        ..._images.map(
          (file) => Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: kIsWeb
                    ? Image.network(
                        file.path, // Blob URL
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(file.path),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
              ),

              /// ❌ Remove
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
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
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
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ColorsManager.grey),
        ),
        child: isLoading
            ? const Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.add, size: 30, color: Colors.grey),
      ),
    );
  }
}
