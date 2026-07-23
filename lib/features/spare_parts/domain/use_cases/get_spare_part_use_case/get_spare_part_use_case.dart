import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/spare_parts/domain/entities/spare_part_entity.dart';
import 'package:meayar_alitqan/features/spare_parts/domain/repos/get_spare_part_repo/get_spare_part_repo.dart';
@injectable
class GetSparePartUseCase {
  final GetSparePartRepo getSparePartRepo;

  GetSparePartUseCase({required this.getSparePartRepo});

  Future<Either<Failures, List<SparePartEntity>>> call(String orderId) async {
    return await getSparePartRepo.getSpareParts(orderId);
  }
}