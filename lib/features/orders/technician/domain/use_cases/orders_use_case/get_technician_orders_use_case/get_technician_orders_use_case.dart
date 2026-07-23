import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../shared/domain/entities/order_entity/order_entity.dart';
import '../../../repositories/orders_repos/get_technician_orders_repo/get_technician_orders_repo.dart';
@injectable
 class GetTechnicianOrdersUseCase {
   GetTechnicianOrdersUseCase(this.getTechnicianOrdersRepo);
   final GetTechnicianOrdersRepo getTechnicianOrdersRepo;
   Future<Either<Failures, List<OrderEntity>>> getTechnicianOrders() {
    return getTechnicianOrdersRepo.getTechnicianOrders();
   }
 }