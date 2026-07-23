import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/spare_parts/domain/entities/spare_part_entity.dart';
import 'package:meayar_alitqan/features/spare_parts/domain/use_cases/get_spare_part_use_case/get_spare_part_use_case.dart';
import 'package:meayar_alitqan/features/spare_parts/presentation/manager/get_spare_part_view_model/get_spare_part_view_model_states.dart';
@injectable
class GetSparePartViewModel extends Cubit<GetSparePartViewModelStates> {
  final GetSparePartUseCase getSparePartUseCase;

  GetSparePartViewModel(this.getSparePartUseCase)
    : super(GetSparePartViewModelInitial());

  Future<void> getSparePart(String orderId) async {
   if (!isClosed) {
  emit(GetSparePartViewModelLoading());
}

    Either<Failures, List<SparePartEntity>> either =
        await getSparePartUseCase(orderId);
    either.fold(
      (l) => emit(GetSparePartViewModelError(l.message)),
      (r) {
        if (!isClosed)
          {
            emit(GetSparePartViewModelSuccess(r));
          };
      },
    );
  }
}
