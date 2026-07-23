import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/auth/domain/use_cases/auth_use_cases/register_usecase/register_usecase.dart';
import 'package:meayar_alitqan/features/auth/presentation/manager/register_view_model/register_view_model_states.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/services/secure_storage_service.dart';
import '../../../../profile/shared/domain/use_cases/get_current_user_usecase/get_current_user_usecase.dart';
import '../../../domain/entities/auth/auth_user_entity/auth_user_entity.dart';

@injectable
class RegisterViewModel extends Cubit<RegisterViewModelStates> {
  // final SendOtpUseCase sendOtpUseCase;
  // final VerifyOtpUseCase verifyOtpUseCase;
  final RegisterUseCase registerUseCase;
  final SecureStorageService secureStorageService;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  RegisterViewModel(
      // this.sendOtpUseCase,
  this.registerUseCase,
      this.secureStorageService,
      this.getCurrentUserUseCase,
      ) : super(RegisterViewModelStatesInitial());

  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool submitted = false;

  void markSubmitted() {
    submitted = true;
    emit(RegisterViewModelStatesInitial());

  }

  /// ================= SEND OTP =================
  Future<void> sendOtp() async {
    emit(RegisterViewModelStatesLoading());

    final result = await registerUseCase.registerUser(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      fullName: fullNameController.text.trim(),
      phone: phoneController.text.trim(),
      role: "customer",
    );

    result.fold(
          (failure) => emit(RegisterViewModelStatesError(message: failure.message)),
          (_) {
        emit(RegisterViewModelStatesSuccess(
        authEntity:  AuthUserEntity(
          email: emailController.text.trim(),
          fullName: fullNameController.text.trim(),
          phone: phoneController.text.trim(), id:  "",

        ),
        ));
      },
    );
  }
  //
  // /// ================= VERIFY OTP =================
  // Future<void> verifyOtp(String otp) async {
  //   emit(RegisterViewModelLoading());
  //
  //   final result = await verifyOtpUseCase.call(
  //     email: emailController.text.trim(),
  //     otp: otp,
  //   );
  //
  //   result.fold(
  //         (failure) => emit(RegisterViewModelError(message: failure.message)),
  //         (user) async {
  //       /// 🔥 حفظ التوكن
  //       await secureStorageService.saveAuthData(
  //         accessToken: user.accessToken!,
  //         refreshToken: user.refreshToken!,
  //         userId: user.id,
  //       );
  //
  //       /// 🔥 تحميل البروفايل
  //       final profileResult = await getCurrentUserUseCase.getCurrentUser(
  //         accessToken: user.accessToken!,
  //       );
  //
  //       profileResult.fold(
  //             (failure) =>
  //             emit(RegisterViewModelError(message: failure.message)),
  //             (_) {
  //           emit(RegisterViewModelSuccess(authUserEntity: user));
  //         },
  //       );
  //     },
  //   );
  // }
}