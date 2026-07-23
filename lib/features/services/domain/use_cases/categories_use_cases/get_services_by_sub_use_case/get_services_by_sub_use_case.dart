import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../entities/category_entity/category_entity.dart';
import '../../../repositories/categories_repos/get_services_by_sub_repo/get_services_by_sub_repo.dart';
@injectable
 class GetServicesBySubUseCase {
    final GetServicesBySubRepo getServicesBySubRepo;
    GetServicesBySubUseCase(this.getServicesBySubRepo);
    Future<Either<Failures, List<CategoryEntity>>> call(String parentId) async {
      return await getServicesBySubRepo.getServicesBySub(parentId);
    }
 }
