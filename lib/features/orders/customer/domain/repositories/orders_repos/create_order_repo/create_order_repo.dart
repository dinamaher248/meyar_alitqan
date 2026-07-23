import 'package:either_dart/either.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../shared/data/models/order_model/order_model.dart';

abstract class CreateOrderRepo {
  Future<Either<Failures, void>> createOrder(OrderModel order);
}