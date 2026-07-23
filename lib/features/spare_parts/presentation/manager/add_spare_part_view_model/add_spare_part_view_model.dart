import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/spare_parts/domain/entities/spare_part_entity.dart';
import 'package:meayar_alitqan/features/spare_parts/domain/use_cases/add_spare_part_use_case/add_spare_part_use_case.dart';
import 'package:meayar_alitqan/features/spare_parts/presentation/manager/add_spare_part_view_model/add_spare_part_view_model_states.dart';

@injectable
class AddSparePartViewModel extends Cubit<AddSparePartViewModelStates> {
  final AddSparePartUseCase addSparePartUseCase;
  AddSparePartViewModel({required this.addSparePartUseCase})
    : super(AddSparePartViewModelInitial());
  Future<void> addSparePart(SparePartEntity sparePartEntity) async {
    Either<Failures, void> result = await addSparePartUseCase.call(
      sparePartEntity,
    );
    result.fold(
      (failure) => emit(AddSparePartViewModelError(failure.message)),
      (spareParts) => emit(AddSparePartViewModelSuccess()),
    );
  }
}
