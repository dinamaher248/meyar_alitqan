import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../features/profile/shared/domain/entities/base_profile_entity/base_profile_entity.dart';
import '../../../features/profile/shared/domain/use_cases/get_current_user_usecase/get_current_user_usecase.dart';

@singleton
class AppUserCubit extends Cubit<BaseProfileEntity?> {
  AppUserCubit(this.getCurrentUserUseCase) : super(null);
  final GetCurrentUserUseCase getCurrentUserUseCase;
  void updateAvatar(String avatarUrl) {
    if (state == null) return;

    emit(
      state!.copyWith(
        avatarUrl: avatarUrl,
      ),
    );
  }
  void updatePhone(String phone) {
    if (state == null) return;

    emit(
      state!.copyWith(
        phone: phone,
      ),
    );
  }
bool get isGuest => state == null;

   void setGuest() => emit(null);
  void setUser(BaseProfileEntity user) => emit(user);
  Future<void> refreshUser() async {
    final session = Supabase.instance.client.auth.currentSession;
    if (session == null) return;

    final result = await getCurrentUserUseCase.getCurrentUser(
      accessToken: session.accessToken,
    );

    result.fold(
          (_) {},
          (user) => emit(user),
    );
  }
 
  void clearUser() {
    if (isClosed) return;
    emit(null);
  }
}
