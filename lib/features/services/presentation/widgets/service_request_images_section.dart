import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/photos_picker_section.dart';

import '../../../../core/di/di.dart';
import '../../../orders/customer/presentation/manager/create_order_view_model/create_order_view_model.dart';
import '../../../uploads/presentation/manager/upload_images_view_model/upload_images_view_model.dart';
import '../../../uploads/presentation/manager/upload_images_view_model/upload_images_view_model_states.dart';

class ServiceRequestImagesSection extends StatelessWidget {
  const ServiceRequestImagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<CreateOrderViewModel>();

    return BlocProvider(
      create: (_) => getIt<UploadImagesViewModel>(),
      child: BlocListener<
          UploadImagesViewModel,
          UploadImagesViewModelStates>(
        listener: (context, state) {
          if (state is UploadImagesViewModelLoading) {
            vm.isUploadingImages = true;
          }

          if (state is UploadImagesViewModelSuccess ||
              state is UploadImagesViewModelError) {
            vm.isUploadingImages = false;
          }

          if (state is UploadImagesViewModelSuccess) {
            vm.uploadedImages.addAll(state.imagePaths);
          }
        },
        child: const PhotosPickerSection(),
      ),
    );
  }
}
