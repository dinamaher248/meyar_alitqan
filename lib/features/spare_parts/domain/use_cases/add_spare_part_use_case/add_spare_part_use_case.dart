import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/spare_parts/domain/entities/spare_part_entity.dart';
import 'package:meayar_alitqan/features/spare_parts/domain/repos/add_spare_part_repo/add_spare_part_repo.dart';
@injectable
class AddSparePartUseCase {
  final AddSparePartRepo addSparePartRepo;

  AddSparePartUseCase(this.addSparePartRepo);
  Future<Either<Failures, void>> call(SparePartEntity sparePartEntity) async =>
   await   addSparePartRepo.addSparePart(sparePartEntity);
}
