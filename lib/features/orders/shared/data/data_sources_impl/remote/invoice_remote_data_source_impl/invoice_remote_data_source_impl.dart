import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/api/api_end_points.dart';
import 'package:meayar_alitqan/core/api/api_manager.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/core/helper/app_messages.dart';
import 'package:meayar_alitqan/core/helper/network_validation.dart';
import 'package:meayar_alitqan/features/orders/shared/data/data_sources/remote/invoice_remote_data_source/invoice_remote_data_source.dart';
import 'package:meayar_alitqan/features/orders/shared/data/models/invoice_model/invoice_model.dart';
import 'package:meayar_alitqan/features/orders/shared/domain/entities/invoice_entity/invoice_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
@Injectable(as: InvoiceRemoteDataSource)
class InvoiceRemoteDataSourceImpl implements InvoiceRemoteDataSource {
  final ApiManager apiManager = ApiManager();

  @override
  Future<Either<Failures, InvoiceEntity>> getInvoiceByOrderId({
    required String orderId,
  }) async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      final session = Supabase.instance.client.auth.currentSession;

      final response = await apiManager.get(
        url: ApiEndPoints.getInvoiceByOrderId,
        token: session?.accessToken,
        query: {
          "order_id": orderId,
        },
      );

      final data = response.data;

      if (data is Map && data['message'] == 'Invoice not found') {
        return Left(ServerFailure('Invoice not found'));
      }


      if (data is! Map) {
        return Left(ServerFailure(AppMessages.serverError));
      }


      if (data['success'] != true || data['data'] == null) {
        return Left(
          ServerFailure(
            data['error'] ??
                data['message'] ??
                AppMessages.serverError,
          ),
        );
      }

 

 

 final invoiceJson =
    Map<String, dynamic>.from(data['data'] as Map);

final invoice = InvoiceModel.fromJson(invoiceJson);
return Right(invoice);

    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
