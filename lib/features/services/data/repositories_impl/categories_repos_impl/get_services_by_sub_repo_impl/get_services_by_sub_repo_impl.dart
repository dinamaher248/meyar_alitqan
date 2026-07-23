 import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/category_entity/category_entity.dart';
import '../../../../domain/repositories/categories_repos/get_services_by_sub_repo/get_services_by_sub_repo.dart';
import '../../../data_sources/remote/categories_remote_data_source/get_services_by_sub_remote_data_source/get_services_by_sub_remote_data_source.dart';
@Injectable(as: GetServicesBySubRepo)
class GetServicesBySubRepoImpl implements GetServicesBySubRepo {
  final GetServicesBySubRemoteDataSource getServicesBySubRemoteDataSource;
  GetServicesBySubRepoImpl(this.getServicesBySubRemoteDataSource);
   @override
   Future<Either<Failures, List<CategoryEntity>>> getServicesBySub(
     String parentId,
   ) {
     return getServicesBySubRemoteDataSource.getServicesBySub(parentId);
   }
 }