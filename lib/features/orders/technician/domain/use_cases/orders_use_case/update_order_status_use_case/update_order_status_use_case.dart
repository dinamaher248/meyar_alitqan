import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../repositories/orders_repos/update_order_status_repo/update_order_status_repo.dart';

@injectable
class UpdateOrderStatusUseCase {
  UpdateOrderStatusUseCase(this.updateOrderStatusRepo);

  final UpdateOrderStatusRepo updateOrderStatusRepo;

  Future<Either<Failures, void>> updateOrderStatus(
    String orderId,
    String status,
  ) {
    return updateOrderStatusRepo.updateOrderStatus(orderId, status);
  }
}
