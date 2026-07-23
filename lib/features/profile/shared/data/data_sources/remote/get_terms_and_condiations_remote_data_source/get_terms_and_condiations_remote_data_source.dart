import 'package:either_dart/either.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/profile/shared/domain/entities/app_documents_entity/app_documents_entity.dart';

abstract class GetTermsAndCondiationsRemoteDataSource {
  Future<Either<Failures, AppDocumentsEntity>> getTermsAndCondiations({
    required String lang,
    required String docKey,
  });
}
