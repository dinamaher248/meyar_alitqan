import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/features/services/domain/use_cases/request_priority_use_cases/get_request_priority_use_case/get_request_priority_use_case.dart';
import 'package:meayar_alitqan/features/services/presentation/manager/get_request_priority_view_model/get_request_priority_view_model_states.dart';

@injectable
class GetRequestPriorityViewModel
    extends Cubit<GetRequestPriorityViewModelStates> {

  final GetRequestPriorityUseCase getRequestPriorityUseCase;

  GetRequestPriorityViewModel({
    required this.getRequestPriorityUseCase,
  }) : super(GetRequestPriorityViewModelInitial());

  Future<void> getRequestPriority() async {
    try {
      emit(GetRequestPriorityViewModelLoading());

      final result = await getRequestPriorityUseCase.call();

      result.fold(
        (failure) {
          emit(GetRequestPriorityViewModelError(failure.message));
        },
        (priorities) {
          emit(GetRequestPriorityViewModelSuccess(priorities));
        },
      );
    } catch (e) {
      emit(GetRequestPriorityViewModelError(e.toString()));
    }
  }
}
