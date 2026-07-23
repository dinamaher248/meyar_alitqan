
 import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/api/api_manager.dart';

import '../../../../../../../core/api/api_end_points.dart';
import '../../../../../../../core/errors/failures.dart';
import '../../../../../../../core/helper/app_messages.dart';
import '../../../../../../../core/helper/network_validation.dart';
import '../../../../../domain/entities/category_entity/category_entity.dart';
import '../../../../data_sources/remote/categories_remote_data_source/get_services_by_sub_remote_data_source/get_services_by_sub_remote_data_source.dart';
import '../../../../models/category_model/category_model.dart';

 @Injectable(as: GetServicesBySubRemoteDataSource)
 class GetServicesBySubRemoteDataSourceImpl
     implements GetServicesBySubRemoteDataSource {

   final ApiManager apiManager = ApiManager();

   @override
   Future<Either<Failures, List<CategoryEntity>>> getServicesBySub(
       String parentId,
       ) async {
     try {
       // 1️⃣ Check Internet
       if (!await NetworkValidation.hasInternet()) {
         return Left(NetworkFailure(AppMessages.noInternet));
       }

       // 2️⃣ Call Edge Function
       final response = await apiManager.post(
         url: ApiEndPoints.getAllServices,
         body: {
           "mode": "service",
           "parent_id": parentId,
         },
       );

       // 3️⃣ Check success
       if (response.data['success'] != true) {
         return Left(ServerFailure(
           response.data['error'] ?? AppMessages.serverError,
         ));
       }

       // 4️⃣ Parse data safely
       final List data = (response.data['data'] as List?) ?? [];

       final services = data
           .map((e) => CategoryModel.fromJson(e))
           .toList();

       // 5️⃣ Return result
       return Right(services);
     } catch (e) {
       return Left(ServerFailure(e.toString()));
     }
   }
 }
