import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../shared/domain/entities/order_entity/order_entity.dart';
import '../../../repositories/orders_repos/get_customer_orders_repo/get_customer_orders_repo.dart';
@injectable
 class GetCustomerOrdersUseCase {
   GetCustomerOrdersUseCase(this.getCustomerOrdersRepo);
   final GetCustomerOrdersRepo getCustomerOrdersRepo;
   Future<Either<Failures, List<OrderEntity>>> getCustomerOrders() {
    return getCustomerOrdersRepo.getCustomerOrders();
   }
 }