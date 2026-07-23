import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/services/secure_storage_service.dart';
import '../../../../profile/shared/domain/use_cases/get_current_user_usecase/get_current_user_usecase.dart';
import '../../../domain/use_cases/auth_use_cases/login_usecase/login_usecase.dart';
import 'login_view_model_states.dart';

@injectable
class LoginViewModel extends Cubit<LoginViewModelStates> {
  final LoginUseCase loginUseCase;
  final SecureStorageService secureStorageService;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  LoginViewModel(
    this.loginUseCase,
    this.secureStorageService,
    this.getCurrentUserUseCase,
  ) : super(LoginViewModelInitial());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool submitted = false;

  void markSubmitted() {
    submitted = true;
    emit(LoginViewModelInitial());
  }
  String? loginError;
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      emit(LoginViewModelLoading());

      final result = await loginUseCase.loginUser(
        email: email,
        password: password,
      );

      await result.fold(
            (failure) async {
          loginError = failure.message;
          emit(LoginViewModelError(message: failure.message));
        },
            (user) async {
          loginError = null;

          await Supabase.instance.client.auth.setSession(
            user.refreshToken!,
          );

          await secureStorageService.saveAuthData(
            accessToken: user.accessToken!,
            refreshToken: user.refreshToken!,
            userId: user.id,
          );

          final profileResult = await getCurrentUserUseCase.getCurrentUser(
            accessToken: user.accessToken!,
          );

          profileResult.fold(
                (failure) {
              emit(LoginViewModelError(message: failure.message));
            },
                (profile) {
              emit(LoginViewModelSuccess(profile: profile));
            },
          );
        },
      );
    } catch (e) {
      emit(LoginViewModelError(message: e.toString()));
    }
  }

  void clearError() {
    loginError = null;
  }
}
