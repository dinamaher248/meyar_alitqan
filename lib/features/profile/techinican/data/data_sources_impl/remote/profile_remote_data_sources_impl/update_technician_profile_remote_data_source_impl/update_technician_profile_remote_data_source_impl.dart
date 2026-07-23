import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:meayar_alitqan/core/api/api_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../../core/errors/failures.dart';
import '../../../../../../../../core/helper/app_messages.dart';
import '../../../../../../../../core/helper/network_validation.dart';
import '../../../../../../../../core/api/api_end_points.dart';
import '../../../../data_sources/remote/profile_remote_data_sources/update_technician_profile_remote_data_source/update_technician_profile_remote_data_source.dart';


@Injectable(as: UpdateTechnicianProfileRemoteDataSource)
class UpdateTechnicianProfileRemoteDataSourceImpl
    implements UpdateTechnicianProfileRemoteDataSource {
  final ApiManager apiManager = ApiManager();

  @override
  Future<Either<Failures, void>> updateProfile({
    String? name,
    String? phone,
    String? avatar,
    String? address,
  }) async {
    try {
      // 1️⃣ Check internet
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      // 2️⃣ Get access token
      final session = Supabase.instance.client.auth.currentSession;
      final accessToken = session?.accessToken;

      if (accessToken == null) {
        return Left(ServerFailure("User not authenticated"));
      }

      // 3️⃣ Call Edge Function
      await apiManager.post(
        url: ApiEndPoints.updateTechnicianProfile,
        token: accessToken,
        body: {"full_name": name, "phone": phone, "avatar_url": avatar, "address": address},
      );

      // 4️⃣ Success
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
