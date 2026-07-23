import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../data_sources/remote/auth_remote_data_sources/reset_password_remote_data_source/reset_password_remote_data_source.dart';
@Injectable(as: ResetPasswordRemoteDataSource)
class ResetPasswordRemoteDataSourceImpl
    implements ResetPasswordRemoteDataSource {

  @override
  Future<Either<Failures, void>> resetPassword({
    required String newPassword,
  }) async {
    try {
      final session = Supabase.instance.client.auth.currentSession;

      if (session == null) {
        return Left(AuthFailure("Recovery session expired"));
      }

      await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: newPassword),
      );

      return const Right(null);
    } catch (e) {
      return Left(
        ServerFailure(e.toString()),
      );
    }
  }
}

 