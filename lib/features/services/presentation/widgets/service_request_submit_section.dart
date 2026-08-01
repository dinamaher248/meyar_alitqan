import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meayar_alitqan/config/routes/routes_manager.dart';
import 'package:meayar_alitqan/core/components/dismissible_error_card.dart';
import 'package:meayar_alitqan/core/cubit/app_user/app_user_cubit.dart';
import '../../../../core/components/custom_button.dart';
import '../../../../core/enums/create_order_validation_error.dart';
import '../../../../core/enums/request_priority.dart';
import '../../../../core/helper/responsive_size.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../orders/customer/presentation/manager/create_order_view_model/create_order_view_model.dart';

class ServiceRequestSubmitSection extends StatelessWidget {
  const ServiceRequestSubmitSection({
    super.key,
    required this.mainCategoryId,
    required this.categoryId,
    required this.subserviceId,
    required this.title,
    required this.location,
    required this.locationDetails,
    required this.locationUrl,
  });

  final String? mainCategoryId;
  final String? categoryId;
  final String? subserviceId;
  final String? title;
  final String? location;
  final String? locationUrl;
  final String? locationDetails;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<CreateOrderViewModel>();
    final t = AppLocalizations.of(context)!;
    final isGuest = context.read<AppUserCubit>().isGuest;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: RS.size(context, 16),
        vertical: RS.size(context, 10),
      ),
      child: CustomButton(
        text: isGuest ? t.guestActionNotAllowed : t.submitRequest,
        onPressed: () async {
          debugPrint("Submit button pressed!");

          if (isGuest) {
            debugPrint("User is guest, redirecting to splash.");
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesManager.splash,
              (_) => false,
            );
            return;
          }

          // ================= ENABLE VALIDATION =================
          vm.enableValidation();

          // ================= CHECK FORM =================
          final formState = vm.formKey.currentState;
          if (formState == null) {
            debugPrint("FormState is null! Cannot submit.");
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Form is not ready!")));
            return;
          }

          if (!formState.validate()) {
            debugPrint("Form validation failed!");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please fill all required fields")),
            );
            return;
          }
          debugPrint("Form validated successfully.");

          // ================= CHECK SCHEDULED DATE =================
          if (vm.selectedPriority == RequestPriority.scheduled &&
              vm.scheduledDate == null) {
            debugPrint("Scheduled date required but missing.");
            showTemporaryMessage(
              context,
              t.scheduledDateRequired,
              MessageType.error,
            );
            return;
          }

          // ================= VALIDATE & BUILD ORDER =================
          debugPrint("Calling validateAndBuildOrder...");
          final result = await vm.validateAndBuildOrder(
            mainCategoryId: mainCategoryId,
            categoryId: categoryId,
            subServiceId: subserviceId,
            title: title,
          );
          debugPrint("validateAndBuildOrder completed: $result");

          // ================= HANDLE RESULT =================
          result.fold(
            (error) {
              debugPrint("validateAndBuildOrder returned error: $error");
              final message = switch (error) {
                CreateOrderValidationError.imagesUploading => t.imagesUploading,
                CreateOrderValidationError.videoUploading => t.videoUploading,
                CreateOrderValidationError.missingScheduledDate =>
                  t.scheduledDateRequired,
                CreateOrderValidationError.unauthenticated =>
                  t.somethingWentWrong,
                _ => "Unknown error",
              };
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: RS.font(context, 14),
                    ),
                  ),
                ),
              );
            },
            (order) {
              debugPrint("Order validated, calling createOrder...");
              vm.createOrder(order);
            },
          );
        },
      ),
    );
  }
}
