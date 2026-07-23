import 'dart:convert';
import '../../l10n/app_localizations.dart';

class SupabaseRegisterErrorMapper {
  static String getMessage(String errorMessage, AppLocalizations loc) {
    String msg = errorMessage.toLowerCase();

    // 🔥 Try to extract message from JSON
    try {
      final decoded = jsonDecode(errorMessage);
      if (decoded is Map && decoded['message'] != null) {
        msg = decoded['message'].toString().toLowerCase();
      }
    } catch (_) {
      // not json → keep original msg
    }

    // Email already exists
    if (msg.contains('already been registered') ||
        msg.contains('already registered')) {
      return loc.emailAlreadyInUse;
    }

    // Invalid email
    if (msg.contains('invalid email')) {
      return loc.invalidEmail;
    }

    // User not found
    if (msg.contains('user not found')) {
      return loc.userNotFound;
    }

    // Wrong password / invalid credentials
    if (msg.contains('invalid login credentials') ||
        msg.contains('wrong password')) {
      return loc.wrongPassword;
    }

    // Weak password
    if (msg.contains('weak') && msg.contains('password')) {
      return loc.invalidPassword;
    }

    // Rate limit
    if (msg.contains('too many requests')) {
      return
          'عدد محاولات كثيرة، حاول لاحقًا';
    }

    // Network
    if (msg.contains('network') ||
        msg.contains('socket') ||
        msg.contains('connection')) {
      return loc.noInternet;
    }

    return loc.somethingWentWrong;
  }
}
