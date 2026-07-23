import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/auth/domain/entities/auth/auth_user_entity/auth_user_entity.dart';
import 'package:meayar_alitqan/features/auth/domain/repositories/auth_repositories/register_repo/register_repo.dart';
import 'package:meayar_alitqan/features/auth/domain/use_cases/auth_use_cases/verify_otp_use_case/verify_otp_use_case.dart';
import 'package:meayar_alitqan/features/auth/presentation/manager/verify_otp_view_model/verify_otp_view_model_states.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../core/errors/failures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/secure_storage_service.dart';
import '../../../../profile/shared/domain/use_cases/get_current_user_usecase/get_current_user_usecase.dart';
@injectable
class VerifyOtpViewModel extends Cubit<VerifyOtpStates> {
  final VerifyOtpUseCase verifyOtpUseCase;
  final SecureStorageService secureStorageService;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  VerifyOtpViewModel(
      this.verifyOtpUseCase,
      this.secureStorageService,
      this.getCurrentUserUseCase,
      ) : super(VerifyOtpInitial());

  Future<void> verifyOtp({
    required String email,
    required String otp,
  }) async {
    emit(VerifyOtpLoading());

    final result = await verifyOtpUseCase.verifyOtp(
      email: email,
      otp: otp,
    );

    await result.fold(
          (failure) async {
        emit(VerifyOtpError(failure.message));
      },
          (user) async {
        try {
          // ✅ 1. set session (زي login)
          await Supabase.instance.client.auth.setSession(
            user.refreshToken!,
          );

          // ✅ 2. save locally
          await secureStorageService.saveAuthData(
            accessToken: user.accessToken!,
            refreshToken: user.refreshToken!,
            userId: user.id,
          );

          // ✅ 3. get full profile
          final profileResult = await getCurrentUserUseCase.getCurrentUser(
            accessToken: user.accessToken!,
          );

          profileResult.fold(
                (failure) {
              emit(VerifyOtpError(failure.message));
            },
                (profile) {
              emit(VerifyOtpSuccess(profile));
            },
          );
        } catch (e) {
          emit(VerifyOtpError(e.toString()));
        }
      },
    );
  }
}