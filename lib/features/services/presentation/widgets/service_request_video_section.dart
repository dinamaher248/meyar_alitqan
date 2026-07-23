import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/features/services/presentation/widgets/videos_picker_section.dart';

import '../../../../core/di/di.dart';
import '../../../orders/customer/presentation/manager/create_order_view_model/create_order_view_model.dart';
import '../../../uploads/presentation/manager/upload_video_view_model/upload_video_view_model.dart';
import '../../../uploads/presentation/manager/upload_video_view_model/upload_video_view_model_states.dart';

class ServiceRequestVideoSection extends StatelessWidget {
  const ServiceRequestVideoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<CreateOrderViewModel>();

    return BlocProvider(
      create: (_) => getIt<UploadVideoViewModel>(),
      child: BlocListener<
          UploadVideoViewModel,
          UploadVideoViewModelStates>(
        listener: (context, state) {
          if (state is UploadVideoViewModelLoading) {
            vm.isUploadingVideo = true;
          }

          if (state is UploadVideoViewModelSuccess ||
              state is UploadVideoViewModelError) {
            vm.isUploadingVideo = false;
          }

          if (state is UploadVideoViewModelSuccess) {
            vm.uploadedVideoPath = state.result.path.last;
          }
        },
        child: const VideosPickerSection(),
      ),
    );
  }
}
