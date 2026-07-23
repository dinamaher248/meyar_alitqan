import 'package:either_dart/either.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/order_entity/order_entity.dart';


abstract class GetOrderDetailsRemoteDataSource {
  Future<Either<Failures, OrderEntity>> getOrderDetails(String orderId);
}