import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/spare_parts/data/data_source/remote/get_spare_part_remote_data_source/get_spare_part_remote_data_source.dart';
import 'package:meayar_alitqan/features/spare_parts/domain/entities/spare_part_entity.dart';
import 'package:meayar_alitqan/features/spare_parts/domain/repos/get_spare_part_repo/get_spare_part_repo.dart';
@Injectable(as:GetSparePartRepo )
class GetSparePartRepoImpl implements GetSparePartRepo{
  final GetSparePartRemoteDataSource getSparePartRemoteDataSource;

  GetSparePartRepoImpl({required this.getSparePartRemoteDataSource});
  @override
  Future<Either<Failures, List<SparePartEntity>>> getSpareParts(String orderId) {
 return getSparePartRemoteDataSource.getSpareParts(orderId);
  }
}