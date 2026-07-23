import 'package:url_launcher/url_launcher.dart';

class CallService {
  static Future<void> makeCall(String phoneNumber) async {
    if (phoneNumber.isEmpty) return;

    final uri = Uri.parse('tel:$phoneNumber');

    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }
}
