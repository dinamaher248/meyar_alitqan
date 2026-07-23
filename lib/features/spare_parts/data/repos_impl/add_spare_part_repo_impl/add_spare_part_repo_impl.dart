import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/spare_parts/data/data_source/remote/add_spare_part_remote_data_source/add_spare_part_remote_data_source.dart';
import 'package:meayar_alitqan/features/spare_parts/domain/entities/spare_part_entity.dart';
import 'package:meayar_alitqan/features/spare_parts/domain/repos/add_spare_part_repo/add_spare_part_repo.dart';
@Injectable(as: AddSparePartRepo)
class AddSparePartRepoImpl implements AddSparePartRepo{
  final AddSparePartRemoteDataSource addSparePartRemoteDataSource;
  AddSparePartRepoImpl(this.addSparePartRemoteDataSource);
  @override
  Future<Either<Failures, void>> addSparePart(SparePartEntity sparePart) {
  return addSparePartRemoteDataSource.addSparePart(sparePart);
  }
}