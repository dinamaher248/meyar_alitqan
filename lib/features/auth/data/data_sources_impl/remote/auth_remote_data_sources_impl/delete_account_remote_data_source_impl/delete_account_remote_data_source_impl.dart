
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../core/api/api_end_points.dart';
import '../../../../../../../core/api/api_manager.dart';
import '../../../../../../../core/errors/failures.dart';
import '../../../../../../../core/helper/app_messages.dart';
import '../../../../../../../core/helper/network_validation.dart';
import '../../../../data_sources/remote/auth_remote_data_sources/delete_account_remote_data_source/delete_account_remote_data_source.dart';
@Injectable(as: DeleteAccountRemoteDataSource)
class DeleteAccountRemoteDataSourceImpl
    implements DeleteAccountRemoteDataSource {
  final ApiManager apiManager = ApiManager();

  @override
  Future<Either<Failures, void>> deleteAccount() async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }
      final session = Supabase.instance.client.auth.currentSession;
      final accessToken = session?.accessToken;
      final response = await apiManager.post(url: ApiEndPoints.deleteAccount,token: accessToken);

      if (response.statusCode == 200) {
        return const Right(null);
      }

      return Left(ServerFailure(response.data.toString()));
    } on DioException catch (e) {
      return Left(
        ServerFailure(e.response?.data?.toString() ?? AppMessages.serverError),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
