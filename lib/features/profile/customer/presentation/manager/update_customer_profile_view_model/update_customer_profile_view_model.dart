import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/profile/customer/domain/use_cases/profile_use_cases/update_customer_profile_use_case/update_customer_profile_use_case.dart';
import 'package:meayar_alitqan/features/profile/customer/presentation/manager/update_customer_profile_view_model/update_customer_profile_view_model_states.dart';

@injectable
class UpdateCustomerProfileViewModel
    extends Cubit<UpdateCustomerProfileViewModelStates> {
  final UpdateCustomerProfileUseCase updateCustomerProfileUseCase;

  UpdateCustomerProfileViewModel(this.updateCustomerProfileUseCase)
    : super(UpdateCustomerProfileViewModelInitial());

  Future<void> updateProfile({
    String? name,
    String? phone,
    String? avatar,
    String? address,
  }) async {
    emit(UpdateCustomerProfileViewModelLoading());
    final result = await updateCustomerProfileUseCase.call(
      name: name,
      phone: phone,
      avatar: avatar,
      address: address,
    );
    result.fold(
      (failure) => emit(UpdateCustomerProfileViewModelError(failure.message)),
      (success) => emit(UpdateCustomerProfileViewModelSuccess()),
    );
  }
}
