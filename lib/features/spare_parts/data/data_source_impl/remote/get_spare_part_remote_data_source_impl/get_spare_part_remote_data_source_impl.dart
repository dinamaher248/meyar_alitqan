import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/api/api_end_points.dart';
import 'package:meayar_alitqan/core/api/api_manager.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/core/helper/app_messages.dart';
import 'package:meayar_alitqan/core/helper/network_validation.dart';
import 'package:meayar_alitqan/features/spare_parts/data/data_source/remote/get_spare_part_remote_data_source/get_spare_part_remote_data_source.dart';
import 'package:meayar_alitqan/features/spare_parts/data/model/spare_part_model.dart';
import 'package:meayar_alitqan/features/spare_parts/domain/entities/spare_part_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@Injectable(as: GetSparePartRemoteDataSource)
class GetSparePartRemoteDataSourceImpl
    implements GetSparePartRemoteDataSource {

  final ApiManager _apiManager = ApiManager();

@override
Future<Either<Failures, List<SparePartEntity>>> getSpareParts(String orderId) async {
  try {
    if (!await NetworkValidation.hasInternet()) {
      return Left(NetworkFailure(AppMessages.noInternet));
    }

    final session = Supabase.instance.client.auth.currentSession;
    if (session == null) {
      return Left(ServerFailure("User not authenticated"));
    }

    final response = await _apiManager.get(
      url: ApiEndPoints.getSpareParts,
      token: session.accessToken,
       query:  {
        "order_id":orderId
       }
    );

   
    final dynamic rawData = response.data;
    final List list = rawData is String
        ? jsonDecode(rawData) as List
        : rawData as List;

    final spareParts = list
        .map((e) => SparePartModel.fromJson(e))
        .toList();

    return Right(spareParts);
  } catch (e) {
    return Left(ServerFailure(e.toString()));
  }
}
}
