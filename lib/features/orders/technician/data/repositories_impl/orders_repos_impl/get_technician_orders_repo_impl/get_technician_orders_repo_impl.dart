import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../shared/domain/entities/order_entity/order_entity.dart';
import '../../../../domain/repositories/orders_repos/get_technician_orders_repo/get_technician_orders_repo.dart';
import '../../../data_sources/remote/orders_remote_data_source/get_technician_orders_remote_data_source/get_technician_orders_remote_data_source.dart';
@Injectable(as: GetTechnicianOrdersRepo)
 class GetTechnicianOrdersRepoImpl implements GetTechnicianOrdersRepo {
   final GetTechnicianOrdersRemoteDataSource remoteDataSource;
   GetTechnicianOrdersRepoImpl(this.remoteDataSource);
  @override
  Future<Either<Failures, List<OrderEntity>>> getTechnicianOrders() {
   return remoteDataSource.getTechnicianOrders();
  }

 }