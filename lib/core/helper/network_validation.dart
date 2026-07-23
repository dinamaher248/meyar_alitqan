import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkValidation {
  static Future<bool> hasInternet() async {
    final connectivity = await Connectivity().checkConnectivity();

    if (connectivity == ConnectivityResult.none) {
      return false;
    }

    // 🌐 Web → كفاية Connectivity
    if (kIsWeb) {
      return true;
    }

    // 📱 Mobile / Desktop → نعمل DNS check
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
