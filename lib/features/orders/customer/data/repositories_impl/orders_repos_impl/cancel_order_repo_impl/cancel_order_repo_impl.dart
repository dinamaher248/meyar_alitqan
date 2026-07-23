import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../domain/repositories/orders_repos/cancel_order_repo/cancel_order_repo.dart';
import '../../../data_sources/remote/orders_remote_data_source/cancel_order_remote_data_source/cancel_order_remote_data_source.dart';
@Injectable(as: CancelOrderRepo)
 class CancelOrderRepoImpl implements CancelOrderRepo {
   final CancelOrderRemoteDataSource cancelOrderRemoteDataSource;
   CancelOrderRepoImpl({required this.cancelOrderRemoteDataSource});
  @override
  Future<Either<Failures, void>> cancelOrder(String orderId) {
    return cancelOrderRemoteDataSource.cancelOrder(orderId);
  }

 }