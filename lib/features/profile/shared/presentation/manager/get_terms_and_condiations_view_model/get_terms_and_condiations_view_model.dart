import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/profile/shared/domain/entities/app_documents_entity/app_documents_entity.dart';
import 'package:meayar_alitqan/features/profile/shared/domain/use_cases/get_terms_and_condiations_use_case/get_terms_and_condiations_use_case.dart';
import 'package:meayar_alitqan/features/profile/shared/presentation/manager/get_terms_and_condiations_view_model/get_terms_and_condiations_view_model_states.dart';
@injectable
class GetTermsAndCondiationsViewModel extends Cubit<GetTermsAndCondiationsViewModelStates>{

  final GetTermsAndCondiationsUseCase  getTermsAndCondiationsUseCase;
  GetTermsAndCondiationsViewModel(this.getTermsAndCondiationsUseCase):super(GetTermsAndCondiationsViewModelInitial());

  Future<void> getTermsAndCondiations({required String lang,required String docKey})async{
    emit(GetTermsAndCondiationsViewModelLoading());
    Either<Failures,AppDocumentsEntity> response = await getTermsAndCondiationsUseCase.call(lang: lang, docKey: docKey);
    response.fold((failures) {
      emit(GetTermsAndCondiationsViewModelError(message: failures.message));
    }, (appDocumentsEntity) {
      emit(GetTermsAndCondiationsViewModelSuccess(appDocumentsEntity: appDocumentsEntity));
    });
  }
}