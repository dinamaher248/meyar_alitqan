import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../shared/domain/entities/order_entity/order_entity.dart';
import '../../../../domain/repositories/orders_repos/get_customer_orders_repo/get_customer_orders_repo.dart';
import '../../../data_sources/remote/orders_remote_data_source/get_customer_orders_remote_data_source/get_customer_orders_remote_data_source.dart';
@Injectable(as: GetCustomerOrdersRepo)
 class GetCustomerOrdersRepoImpl implements GetCustomerOrdersRepo {
   final GetCustomerOrdersRemoteDataSource getCustomerOrdersRemoteDataSource;
   GetCustomerOrdersRepoImpl({required this.getCustomerOrdersRemoteDataSource});
   @override
   Future<Either<Failures, List<OrderEntity>>> getCustomerOrders() {
      return getCustomerOrdersRemoteDataSource.getCustomerOrders();
   }

 }