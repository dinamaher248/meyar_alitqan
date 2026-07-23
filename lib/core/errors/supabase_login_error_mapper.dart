import 'dart:convert';
import '../../l10n/app_localizations.dart';

class SupabaseLoginErrorMapper {
  static String getMessage(String errorMessage, AppLocalizations loc) {
    String msg = errorMessage.toLowerCase();

    // 🔹 Try extract JSON message
    try {
      final decoded = jsonDecode(errorMessage);
      if (decoded is Map && decoded['message'] != null) {
        msg = decoded['message'].toString().toLowerCase();
      }
    } catch (_) {}

    // ❌ Invalid credentials (email OR password)
    if (msg.contains('invalid login credentials') ||
        msg.contains('wrong password') ||
        msg.contains('invalid credentials')) {
      return loc.wrongPassword;
    }

    // ❌ User not found
    if (msg.contains('user not found') ||
        msg.contains('no user')) {
      return loc.userNotFound;
    }

    // ❌ Email not confirmed
    if (msg.contains('email not confirmed') ||
        msg.contains('email not verified')) {
      return loc.emailNotVerified;
    }

    // ❌ Account disabled / banned
    if (msg.contains('disabled') ||
        msg.contains('blocked') ||
        msg.contains('banned')) {
      return loc.accountDisabled;
    }

    // 🌐 Network issues
    if (msg.contains('network') ||
        msg.contains('socket') ||
        msg.contains('connection')) {
      return loc.noInternet;
    }

    // 🛑 Too many attempts
    if (msg.contains('too many requests')) {
      return 'عدد محاولات تسجيل الدخول كثيرة، حاول لاحقًا';
    }

    return loc.invalidLoginData;
  }
}
