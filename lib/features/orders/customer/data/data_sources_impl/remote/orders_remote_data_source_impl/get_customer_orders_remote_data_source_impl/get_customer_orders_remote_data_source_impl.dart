import 'dart:convert';

import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:meayar_alitqan/core/errors/failures.dart';

import 'package:meayar_alitqan/features/orders/shared/domain/entities/order_entity/order_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../core/api/api_end_points.dart';
import '../../../../../../../../core/api/api_manager.dart';
import '../../../../../../../../core/helper/app_messages.dart';
import '../../../../../../../../core/helper/network_validation.dart';
import '../../../../../../shared/data/models/order_model/order_model.dart';
import '../../../../data_sources/remote/orders_remote_data_source/get_customer_orders_remote_data_source/get_customer_orders_remote_data_source.dart';

@Injectable(as: GetCustomerOrdersRemoteDataSource)
class GetCustomerOrdersRemoteDataSourceImpl
    implements GetCustomerOrdersRemoteDataSource {

  final ApiManager apiManager = ApiManager();

  @override
  Future<Either<Failures, List<OrderEntity>>> getCustomerOrders() async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      final session = Supabase.instance.client.auth.currentSession;
      final accessToken = session?.accessToken;

      if (accessToken == null) {
        return Left(ServerFailure("User not authenticated"));
      }

      final response = await apiManager.get(
        url: ApiEndPoints.getCustomerOrders,
        token: accessToken,
      );

      final dynamic rawData = response.data;

      final List<dynamic> ordersJson = rawData is String
          ? jsonDecode(rawData) as List<dynamic>
          : rawData as List<dynamic>;

      final orders = ordersJson
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return Right(orders);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

}
