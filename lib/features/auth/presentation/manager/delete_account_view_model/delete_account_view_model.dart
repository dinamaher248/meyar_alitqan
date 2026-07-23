import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/auth/domain/use_cases/auth_use_cases/delete_account_usecase/delete_account_usecase.dart';

import 'delete_account_view_model_states.dart';
@injectable
class DeleteAccountViewModel extends Cubit<DeleteAccountViewModelStates> {
  final DeleteAccountUseCase deleteAccountUseCase ;
  DeleteAccountViewModel(this.deleteAccountUseCase) : super(DeleteAccountViewModelInitial());

  Future<void> deleteAccount() async {
    emit(DeleteAccountViewModelLoading());
    final result = await deleteAccountUseCase.deleteAccount();
    result.fold(
      (failure) => emit(DeleteAccountViewModelError(message: failure.message)),
      (success) => emit(DeleteAccountViewModelSuccess()),
    );
  }
}