import 'package:either_dart/either.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/services/domain/entities/request_priority_entity/request_priority_entity.dart';

abstract class GetRequestPriorityRepo {
  Future<Either<Failures, List<RequestPriorityEntity>>> getRequestPriority();
}