import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:meayar_alitqan/core/errors/failures.dart';

import 'package:meayar_alitqan/features/orders/shared/domain/entities/order_entity/order_entity.dart';

import '../../../domain/repositories/get_order_details_repo/get_order_details_repo.dart';
import '../../data_sources/remote/get_order_details_remote_data_source/get_order_details_remote_data_source.dart';

@Injectable(as: GetOrderDetailsRepo)
class GetOrderDetailsRepoImpl implements GetOrderDetailsRepo {
  final GetOrderDetailsRemoteDataSource getOrderDetailsRemoteDataSource;

  GetOrderDetailsRepoImpl(this.getOrderDetailsRemoteDataSource);

  @override
  Future<Either<Failures, OrderEntity>> getOrderDetails(String orderId) {
    return getOrderDetailsRemoteDataSource.getOrderDetails(orderId);
  }
}
