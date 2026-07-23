import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/auth/domain/use_cases/auth_use_cases/google_use_case/google_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/services/secure_storage_service.dart';
import '../../../../profile/shared/domain/use_cases/get_current_user_usecase/get_current_user_usecase.dart';
import 'google_auth_view_model_states.dart';

@injectable
class GoogleAuthViewModel extends Cubit<GoogleAuthViewModelStates> {
  final GoogleUseCase googleUseCase;
  final SecureStorageService secureStorageService;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  GoogleAuthViewModel(
    this.googleUseCase,
    this.secureStorageService,
    this.getCurrentUserUseCase,
  ) : super(GoogleAuthViewModelInitial());

  Future<void> signInWithGoogle() async {
    try {
      emit(GoogleAuthViewModelLoading());

      /// 🌐 WEB
      if (kIsWeb) {
        await googleUseCase.signInWithGoogle();
        return; // 👈 وقف هنا
      }

      /// 📱 MOBILE
      final result = await googleUseCase.signInWithGoogle();

      await result.fold(
            (failure) async {
          emit(GoogleAuthViewModelError(failure.message));
        },
            (user) async {
          final session = Supabase.instance.client.auth.currentSession;

          if (session == null) {
            emit(GoogleAuthViewModelError('SESSION_NOT_READY'));
            return;
          }

          final accessToken = session.accessToken;

          await secureStorageService.saveAuthData(
            accessToken: accessToken,
            refreshToken: session.refreshToken,
            userId: user.id,
          );

          final profileResult =
          await getCurrentUserUseCase.getCurrentUser(
            accessToken: accessToken,
          );

          profileResult.fold(
                (failure) {
              emit(GoogleAuthViewModelError(failure.message));
            },
                (profile) {
              emit(GoogleAuthViewModelSuccess(profile));
            },
          );
        },
      );
    } catch (e) {
      emit(GoogleAuthViewModelError(e.toString()));
    }
  }
}
