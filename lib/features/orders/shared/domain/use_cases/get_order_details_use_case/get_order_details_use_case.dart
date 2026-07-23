import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../entities/order_entity/order_entity.dart';
import '../../repositories/get_order_details_repo/get_order_details_repo.dart';
@injectable
 class GetOrderDetailsUseCase {
   GetOrderDetailsUseCase(this.getOrderDetailsRepo);
   final GetOrderDetailsRepo getOrderDetailsRepo;
   Future<Either<Failures, OrderEntity>> getOrderDetails(String orderId) {
    return getOrderDetailsRepo.getOrderDetails(orderId);
   }
 }