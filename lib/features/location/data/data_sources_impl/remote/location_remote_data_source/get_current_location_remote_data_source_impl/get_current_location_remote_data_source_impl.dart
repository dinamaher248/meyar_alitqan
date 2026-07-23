import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import 'package:meayar_alitqan/core/errors/failures.dart';
import 'package:meayar_alitqan/features/location/domain/entities/user_location_entity/user_location_entity.dart';
import '../../../../../../../core/helper/app_messages.dart';
import '../../../../../../../core/helper/network_validation.dart';
import '../../../../data_sources/remote/location_remote_data_source/get_current_location_remote_data_source/get_current_location_remote_data_source.dart';

@Injectable(as: GetCurrentLocationRemoteDataSource)
class GetCurrentLocationRemoteDataSourceImpl
    implements GetCurrentLocationRemoteDataSource {

  @override
  Future<Either<Failures, UserLocationEntity>> getCurrentLocation() async {
    try {
      if (!await NetworkValidation.hasInternet()) {
        return Left(NetworkFailure(AppMessages.noInternet));
      }

      // 1️⃣ Location service
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return const Left(LocationFailure('LOCATION_SERVICE_DISABLED'));
      }

      // 2️⃣ Permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        return const Left(LocationFailure('LOCATION_PERMISSION_DENIED'));
      }

      if (permission == LocationPermission.deniedForever) {
        return const Left(
          LocationFailure('LOCATION_PERMISSION_DENIED_FOREVER'),
        );
      }

      // 3️⃣ Get position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // 4️⃣ Reverse geocoding
      String? address;
      try {
        final placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placemarks.isNotEmpty) {
          final p = placemarks.first;
          address =
          '${p.street}, ${p.locality}, ${p.administrativeArea}, ${p.country}';
        }
      } catch (_) {
        // fallback لو geocoding فشل
        address =
        '${position.latitude}, ${position.longitude}';
      }

      return Right(
        UserLocationEntity(
          latitude: position.latitude,
          longitude: position.longitude,
          address: address,
        ),
      );
    } catch (e) {
      return Left(LocationFailure(e.toString()));
    }
  }
}
