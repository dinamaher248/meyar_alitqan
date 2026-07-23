import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/api/api_manager.dart';

import '../../../../../../../core/api/api_end_points.dart';
import '../../../../../../../core/errors/failures.dart';
import '../../../../../../../core/helper/app_messages.dart';
import '../../../../../../../core/helper/network_validation.dart';
import '../../../../data_sources/remote/auth_remote_data_sources/forget_password_remote_data_source/forget_password_remote_data_source.dart';
@Injectable(as: ForgetPasswordRemoteDataSource)
class ForgetPasswordRemoteDataSourceImpl
    implements ForgetPasswordRemoteDataSource {
  final ApiManager apiManager = ApiManager();

  @override
  Future<Either<Failures, void>> sendResetLink(String email) async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      final response = await apiManager.post(
        url: ApiEndPoints.sendResetPassword,
        body: {'email': email},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return const Right(null);
      } else {
        return Left(
          ServerFailure(
            response.data?['message'] ?? AppMessages.somethingWentWrong,
          ),
        );
      }
    } catch (e) {
      return Left(
        ServerFailure(AppMessages.somethingWentWrong),
      );
    }
  }
}
