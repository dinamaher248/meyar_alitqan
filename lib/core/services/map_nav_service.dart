import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class MapNavigationService {

  static Future<void> _ensurePermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled';
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permission permanently denied';
    }
  }


  static Future<Position> _getCurrentLocation() async {
    await _ensurePermission();
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }


  static Future<void> openDirectionsToLatLng({
    required double destLat,
    required double destLng,
  }) async {
    final position = await _getCurrentLocation();

    final url = Platform.isIOS
        ? Uri.parse(
      'https://maps.apple.com/?saddr=${position.latitude},${position.longitude}'
          '&daddr=$destLat,$destLng',
    )
        : Uri.parse(
      'https://www.google.com/maps/dir/?api=1'
          '&origin=${position.latitude},${position.longitude}'
          '&destination=$destLat,$destLng'
          '&travelmode=driving',
    );

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch maps';
    }
  }

  static Future<void> openDirectionsToLink({
    required String destinationLink,
  }) async {
    // 🔴 تنظيف اللينك
    final cleanLink = destinationLink
        .replaceAll('"', '')
        .replaceAll("'", '')
        .replaceAll('\n', '')
        .trim();

    final uri = Uri.parse(cleanLink);

    // 🔥 افتح مباشرة بدون canLaunch
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }
}
