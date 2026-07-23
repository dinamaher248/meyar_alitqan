import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppService {
  static Future<void> openChat({
    required String phone,
    required String message,
  }) async {
    final encodedMessage = Uri.encodeComponent(message);

    final webUrl = Uri.parse(
      "https://wa.me/$phone?text=$encodedMessage",
    );

    final appUrl = Uri.parse(
      "whatsapp://send?phone=$phone&text=$encodedMessage",
    );

    try {
      if (!kIsWeb && await canLaunchUrl(appUrl)) {
        await launchUrl(
          appUrl,
          mode: LaunchMode.externalApplication,
        );
      } else {
        await launchUrl(
          webUrl,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (_) {
 
      await launchUrl(
        webUrl,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
