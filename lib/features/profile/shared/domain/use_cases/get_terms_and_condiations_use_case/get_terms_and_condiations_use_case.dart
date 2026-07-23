import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/profile/shared/domain/entities/app_documents_entity/app_documents_entity.dart';
import 'package:meayar_alitqan/features/profile/shared/domain/repositories/get_terms_and_condiations_repo/get_terms_and_condiations_repo.dart';
@injectable
class GetTermsAndCondiationsUseCase {
  final GetTermsAndCondiationsRepo repo;
  GetTermsAndCondiationsUseCase(this.repo);
  Future<Either<Failures, AppDocumentsEntity>> call(
 {
    required String lang
,
    required String docKey 
 }
  ) => repo.getTermsAndCondiations(docKey: docKey, lang: lang);
}
