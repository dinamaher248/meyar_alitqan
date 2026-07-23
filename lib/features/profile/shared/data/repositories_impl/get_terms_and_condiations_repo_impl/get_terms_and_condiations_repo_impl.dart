import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/profile/shared/data/data_sources/remote/get_terms_and_condiations_remote_data_source/get_terms_and_condiations_remote_data_source.dart';
import 'package:meayar_alitqan/features/profile/shared/domain/entities/app_documents_entity/app_documents_entity.dart';
import 'package:meayar_alitqan/features/profile/shared/domain/repositories/get_terms_and_condiations_repo/get_terms_and_condiations_repo.dart';
@Injectable(as:  GetTermsAndCondiationsRepo)
class GetTermsAndCondiationsRepoImpl implements GetTermsAndCondiationsRepo {
  final GetTermsAndCondiationsRemoteDataSource remoteDataSource;
  GetTermsAndCondiationsRepoImpl({required this.remoteDataSource});

  @override

  Future<Either<Failures, AppDocumentsEntity>> getTermsAndCondiations({
    required String lang,
    required String docKey,
  }) {
    return  remoteDataSource.getTermsAndCondiations(lang: lang, docKey: docKey);
  }
}
