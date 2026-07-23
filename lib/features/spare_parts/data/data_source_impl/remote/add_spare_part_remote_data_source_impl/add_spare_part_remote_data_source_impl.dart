import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/api/api_end_points.dart';
import 'package:meayar_alitqan/core/api/api_manager.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/core/helper/app_messages.dart';
import 'package:meayar_alitqan/core/helper/network_validation.dart';
import 'package:meayar_alitqan/features/spare_parts/data/data_source/remote/add_spare_part_remote_data_source/add_spare_part_remote_data_source.dart';
import 'package:meayar_alitqan/features/spare_parts/data/model/spare_part_model.dart';
import 'package:meayar_alitqan/features/spare_parts/domain/entities/spare_part_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@Injectable(as: AddSparePartRemoteDataSource)
class AddSparePartRemoteDataSourceImpl
    implements AddSparePartRemoteDataSource {

  final ApiManager _apiManager = ApiManager();

  @override
  Future<Either<Failures, void>> addSparePart(
      SparePartEntity sparePart) async {
    try {
      // 🌐 check internet
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      // 🔐 auth
      final session = Supabase.instance.client.auth.currentSession;
      if (session == null) {
        return Left(ServerFailure("User not authenticated"));
      }

      final model = SparePartModel(
        id: '',
        orderId: sparePart.orderId,
        technicianId: sparePart.technicianId,
        partName: sparePart.partName,
        partDescription: sparePart.partDescription,
        quantity: sparePart.quantity,
        estimatedPrice: sparePart.estimatedPrice,
        status: sparePart.status,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // 🚀 call edge function
      await _apiManager.post(
        url: ApiEndPoints.manageSparePart,
        body: model.toJson(),
        token: session.accessToken,
      );

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
