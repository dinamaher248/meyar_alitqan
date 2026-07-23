import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../entities/order_entity/order_entity.dart';

abstract class GetOrderDetailsRepo {
  Future<Either<Failures, OrderEntity>> getOrderDetails(String orderId);
}