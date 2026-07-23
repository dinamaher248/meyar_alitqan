import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../shared/data/models/order_model/order_model.dart';
import '../../../../domain/repositories/orders_repos/create_order_repo/create_order_repo.dart';
import '../../../data_sources/remote/orders_remote_data_source/create_order_remote_data_source/create_order_remote_data_source.dart';

@Injectable(as: CreateOrderRepo)
class CreateOrderRepoImpl implements CreateOrderRepo {
  final CreateOrderRemoteDataSource createOrderRemoteDataSource;

  CreateOrderRepoImpl({required this.createOrderRemoteDataSource});

  @override
  Future<Either<Failures, void>> createOrder(OrderModel order) {
    return createOrderRemoteDataSource.createOrder(order);
  }
}
