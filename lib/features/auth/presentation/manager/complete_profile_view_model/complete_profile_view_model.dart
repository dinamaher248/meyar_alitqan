import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/profile_service.dart';

part 'complete_profile_states.dart';

@injectable
class CompleteProfileViewModel extends Cubit<CompleteProfileStates> {
  CompleteProfileViewModel() : super(CompleteProfileInitial());

  Future<void> submitPhone(String phone) async {
    emit(CompleteProfileLoading());

    try {
      await ProfileService.updatePhone(phone);
      emit(CompleteProfileSuccess(phone));
    } catch (e) {
      emit(CompleteProfileError(e.toString()));
    }
  }
}
