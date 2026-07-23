import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/profile/techinican/presentation/manager/update_techinican_profile_view_model/update_technician_profile_view_model_states.dart';

import '../../../domain/use_cases/profile_use_cases/update_technician_profile_use_case/update_technician_profile_use_case.dart';

@injectable
class UpdateTechnicianProfileViewModel
    extends Cubit<UpdateTechnicianProfileViewModelStates> {
  final UpdateTechnicianProfileUseCase updateTechnicianProfileUseCase;

  UpdateTechnicianProfileViewModel(this.updateTechnicianProfileUseCase)
    : super(UpdateTechnicianProfileViewModelInitial());

  Future<void> updateProfile({
    String? name,
    String? phone,
    String? avatar,
    String? address,
  }) async {
    emit(UpdateTechnicianProfileViewModelLoading());

    final result = await updateTechnicianProfileUseCase.call(
      name: name,
      phone: phone,
      avatar: avatar,
      address: address,
    );

    result.fold(
      (failure) => emit(UpdateTechnicianProfileViewModelError(failure.message)),
      (success) => emit(UpdateTechnicianProfileViewModelSuccess()),
    );
  }
}
