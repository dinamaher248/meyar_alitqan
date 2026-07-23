import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../shared/data/models/order_model/order_model.dart';
import '../../../../../shared/domain/entities/order_entity/order_entity.dart';
import '../../../repositories/orders_repos/create_order_repo/create_order_repo.dart';
@injectable
 class CreateOrderUseCase {
   CreateOrderUseCase(this.createOrderRepo);
   final CreateOrderRepo createOrderRepo;
   Future<Either<Failures, void>> createOrder(OrderEntity order) {
     final model = OrderModel.fromEntity(order);
     return createOrderRepo.createOrder(model);

   }

}