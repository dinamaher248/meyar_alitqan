import 'package:either_dart/either.dart';

import '../../../../../../../core/errors/failures.dart';

abstract class CancelOrderRepo {
  Future<Either<Failures, void>> cancelOrder(String orderId);
}