import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/api/api_end_points.dart';
import 'package:meayar_alitqan/core/api/api_manager.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/core/helper/app_messages.dart';
import 'package:meayar_alitqan/core/helper/network_validation.dart';
import 'package:meayar_alitqan/features/profile/shared/data/data_sources/remote/get_terms_and_condiations_remote_data_source/get_terms_and_condiations_remote_data_source.dart';
import 'package:meayar_alitqan/features/profile/shared/data/models/app_documents_model/app_documents_model.dart';
import 'package:meayar_alitqan/features/profile/shared/domain/entities/app_documents_entity/app_documents_entity.dart';
@Injectable(as: GetTermsAndCondiationsRemoteDataSource)
class GetTermsAndCondiationsRemoteDataSourceImpl
    implements GetTermsAndCondiationsRemoteDataSource {

  final ApiManager apiManager = ApiManager();

  @override
  Future<Either<Failures, AppDocumentsEntity>> getTermsAndCondiations({
    required String lang,
    required String docKey,
  }) async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      final response = await apiManager.get(
        url: ApiEndPoints.getTermsAndCondiations,
        query: {
          'lang': lang,
          'doc_key': docKey,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is List && data.isNotEmpty) {
          return Right(
            AppDocumentsModel.fromJson(data[0]),
          );
        } else if (data is Map<String, dynamic>) {
          return Right(
            AppDocumentsModel.fromJson(data),
          );
        } else {
          return Left(ServerFailure("No data found"));
        }
      }

      return Left(
        ServerFailure(response.data.toString()),
      );
    } catch (e) {
      return Left(
        ServerFailure(e.toString()),
      );
    }
  }
}
