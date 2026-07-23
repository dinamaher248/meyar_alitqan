import 'package:either_dart/either.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/spare_parts/domain/entities/spare_part_entity.dart';

abstract class AddSparePartRepo {
 Future<Either<Failures, void>> addSparePart(SparePartEntity sparePart);
}