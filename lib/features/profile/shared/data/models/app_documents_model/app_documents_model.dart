import 'package:meayar_alitqan/features/profile/shared/domain/entities/app_documents_entity/app_documents_entity.dart';

class AppDocumentsModel extends AppDocumentsEntity{
 AppDocumentsModel(
  {
    super.id,
    super.content,
    super.doc_key,
    super.lang,
   
    super.createdAt,
    super.updatedAt
  }
 );


  factory AppDocumentsModel.fromJson(Map<String, dynamic> json) {
    return AppDocumentsModel(
      id: json['id'],
      content: json['content'],
      doc_key: json['doc_key'],
      lang: json['lang'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  factory AppDocumentsModel.fromEntity(AppDocumentsEntity entity) {
    return AppDocumentsModel(
      id: entity.id,
      content: entity.content,
      doc_key: entity.doc_key,
      lang: entity.lang,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

 

}