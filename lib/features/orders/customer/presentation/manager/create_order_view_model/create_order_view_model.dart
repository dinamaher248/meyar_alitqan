import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/orders/customer/domain/use_cases/orders_use_cases/create_order_use_case/create_order_use_case.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../core/enums/create_order_validation_error.dart';
import '../../../../../../core/enums/order_status.dart';
import '../../../../../../core/enums/request_priority.dart';
import '../../../../../../core/services/secure_storage_service.dart';
import '../../../../shared/domain/entities/order_entity/order_entity.dart';
import 'create_order_view_model_states.dart';

@injectable
class CreateOrderViewModel extends Cubit<CreateOrderViewModelStates> {
  final CreateOrderUseCase createOrderUseCase;
  final SecureStorageService secureStorageService;

  CreateOrderViewModel(
    this.createOrderUseCase,
    this.secureStorageService,
  ) : super(CreateOrderViewModelInitial());

  // ================= Controllers =================

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  /// المكان المختار من الـ dialog (المنطقة / الحي)
  final TextEditingController locationAreaController = TextEditingController();

  /// تفاصيل العنوان (شارع – عمارة – دور)
  final TextEditingController locationDetailsController =
      TextEditingController();

  /// Google Maps URL (اختياري)
  final TextEditingController locationUrlController = TextEditingController();

  // ================= State =================

  final List<String> uploadedImages = [];
  String? uploadedVideoPath;

  bool isUploadingImages = false;
  bool isUploadingVideo = false;

  DateTime? scheduledDate;
  RequestPriority selectedPriority = RequestPriority.scheduled;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  // ================= Helpers =================

  void enableValidation() {
    autovalidateMode = AutovalidateMode.onUserInteraction;
  }

  void setScheduledDate(DateTime? date) {
    scheduledDate = date;
  }

  void addImages(List<String> paths) {
    uploadedImages.addAll(paths);
  }

  void removeImage(String path) {
    uploadedImages.remove(path);
  }

  Future<String?> get customerId async {
    return await secureStorageService.getUserId();
  }

  // ================= Create Order =================

  Future<void> createOrder(OrderEntity order) async {
    emit(CreateOrderViewModelLoading());

    final result = await createOrderUseCase.createOrder(order);

    result.fold(
      (failure) => emit(CreateOrderViewModelError(failure.message)),
      (_) => emit(CreateOrderViewModelSuccess()),
    );
  }

  // ================= Validation + Build =================

  Future<Either<CreateOrderValidationError, OrderEntity>>
      validateAndBuildOrder({
    required String? mainCategoryId,
    required String? categoryId,
    required String? subServiceId,
    required String? title,
  }) async {
    final description = descriptionController.text.trim();
    final area = locationAreaController.text.trim();
    final details = locationDetailsController.text.trim();

    final fullLocation = "$area, $details";

    // ---------- Validation ----------

    if (description.isEmpty || description.length < 10) {
      return const Left(CreateOrderValidationError.invalidDescription);
    }

    if (isUploadingImages) {
      return const Left(CreateOrderValidationError.imagesUploading);
    }

    if (isUploadingVideo) {
      return const Left(CreateOrderValidationError.videoUploading);
    }

    if (selectedPriority == RequestPriority.scheduled &&
        scheduledDate == null) {
      return const Left(CreateOrderValidationError.missingScheduledDate);
    }

    if (area.isEmpty) {
      return const Left(CreateOrderValidationError.invalidLocation);
    }

    if (details.isEmpty) {
      return const Left(CreateOrderValidationError.invalidLocation);
    }

    final customerId = await secureStorageService.getUserId();
    if (customerId == null) {
      return const Left(CreateOrderValidationError.unauthenticated);
    }

    // ---------- Build Order ----------

    return Right(
      OrderEntity(
        id: const Uuid().v4(),
        customerId: customerId,
        mainCategoryId: mainCategoryId,
        categoryId: categoryId ?? '',
        subServiceId: subServiceId ?? '',
        title: title ?? '',
        description: description,
        location: fullLocation,
        locationUrl: locationUrlController.text.trim(),
        images: uploadedImages,
        videos: uploadedVideoPath != null ? [uploadedVideoPath!] : [],
        level: selectedPriority,
        scheduledDate: scheduledDate,
        status: OrderStatus.pending,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }

  // ================= Dispose =================

  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();
    locationAreaController.dispose();
    locationDetailsController.dispose();
    locationUrlController.dispose();
    return super.close();
  }
}
