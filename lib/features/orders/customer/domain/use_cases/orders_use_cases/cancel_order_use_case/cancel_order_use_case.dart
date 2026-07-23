import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../repositories/orders_repos/cancel_order_repo/cancel_order_repo.dart';
@injectable
 class CancelOrderUseCase {
   CancelOrderUseCase(this.cancelOrderRepo);
   final CancelOrderRepo cancelOrderRepo;
   Future<Either<Failures, void>> cancelOrder(String orderId) {
    return cancelOrderRepo.cancelOrder(orderId);
   }


 }