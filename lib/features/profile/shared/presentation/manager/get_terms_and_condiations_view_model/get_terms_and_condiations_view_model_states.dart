import 'package:meayar_alitqan/features/profile/shared/domain/entities/app_documents_entity/app_documents_entity.dart';

abstract class GetTermsAndCondiationsViewModelStates {}

class GetTermsAndCondiationsViewModelInitial
  extends GetTermsAndCondiationsViewModelStates {}

class GetTermsAndCondiationsViewModelSuccess
  extends GetTermsAndCondiationsViewModelStates {
    final AppDocumentsEntity appDocumentsEntity;
    GetTermsAndCondiationsViewModelSuccess({required this.appDocumentsEntity});
  }

class GetTermsAndCondiationsViewModelError
  extends GetTermsAndCondiationsViewModelStates {
    final String message;
    GetTermsAndCondiationsViewModelError({required this.message});
  }

class GetTermsAndCondiationsViewModelLoading
  extends GetTermsAndCondiationsViewModelStates {}