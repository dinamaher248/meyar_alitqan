import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/api/api_end_points.dart';
import 'package:meayar_alitqan/core/api/api_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../core/errors/failures.dart';
import '../../../../../../../../core/helper/app_messages.dart';
import '../../../../../../../../core/helper/network_validation.dart';
import '../../../../../../shared/data/models/order_model/order_model.dart';
import '../../../../data_sources/remote/orders_remote_data_source/get_technician_orders_remote_data_source/get_technician_orders_remote_data_source.dart';
@Injectable(as: GetTechnicianOrdersRemoteDataSource)
class GetTechnicianOrdersRemoteDataSourceImpl
    implements GetTechnicianOrdersRemoteDataSource {
  final ApiManager apiManager = ApiManager();

  @override
  Future<Either<Failures, List<OrderModel>>> getTechnicianOrders() async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      final accessToken =
          Supabase.instance.client.auth.currentSession?.accessToken;

      if (accessToken == null) {
        return Left(ServerFailure('ACCESS_TOKEN_NOT_FOUND'));
      }

      final response = await apiManager.get(
        url: ApiEndPoints.getAssignedOrders,
        token: accessToken,
      );

      if (response.statusCode == 200) {
        final data = response.data is String
            ? jsonDecode(response.data)
            : response.data;

        final ordersJson = data is List ? data : data['orders'];

        if (ordersJson == null) {
          return Left(ServerFailure('ORDERS_NOT_FOUND'));
        }

        final orders =
        List<Map<String, dynamic>>.from(ordersJson);

        return Right(
          orders.map(OrderModel.fromJson).toList(),
        );
      } else {
        return Left(ServerFailure(response.data.toString()));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
