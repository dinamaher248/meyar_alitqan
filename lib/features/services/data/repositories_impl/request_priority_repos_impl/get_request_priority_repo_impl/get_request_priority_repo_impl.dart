import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/services/data/data_sources/remote/request_priority_remote_data_sources/get_request_priority_remote_data_source/get_request_priority_remote_data_source.dart';
import 'package:meayar_alitqan/features/services/domain/entities/request_priority_entity/request_priority_entity.dart';
import 'package:meayar_alitqan/features/services/domain/repositories/request_priority_repos/get_request_priority_repo/get_request_priority_repo.dart';
@Injectable(as: GetRequestPriorityRepo)
 class GetRequestPriorityRepoImpl implements GetRequestPriorityRepo {
  final GetRequestPriorityRemoteDataSource getRequestPriorityRemoteDataSource;
  GetRequestPriorityRepoImpl(this.getRequestPriorityRemoteDataSource);
  @override
  Future<Either<Failures, List<RequestPriorityEntity>>> getRequestPriority() async {
    return await getRequestPriorityRemoteDataSource.getRequestPriority();
  }
}