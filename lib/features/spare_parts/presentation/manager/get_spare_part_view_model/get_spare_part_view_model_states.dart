import 'package:meayar_alitqan/features/spare_parts/domain/entities/spare_part_entity.dart';

abstract class GetSparePartViewModelStates {}
class GetSparePartViewModelInitial extends GetSparePartViewModelStates {}
class GetSparePartViewModelSuccess extends GetSparePartViewModelStates {
  final List<SparePartEntity> spareParts;
  GetSparePartViewModelSuccess(this.spareParts);
}
class GetSparePartViewModelError extends GetSparePartViewModelStates {
  final String message;
  GetSparePartViewModelError(this.message);
}

class GetSparePartViewModelLoading extends GetSparePartViewModelStates {}
