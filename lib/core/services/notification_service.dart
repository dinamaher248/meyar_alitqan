import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'local_notifications_service.dart';

class NotificationService {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  static Future<void> init() async {
    // 🔔 Request permission (iOS + Android 13)
    await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // 📱 Get FCM Token
    final token = await _fcm.getToken();
    debugPrint('🔥 FCM Token: $token');

    // 🔁 Token refresh
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      debugPrint('🔄 New FCM Token: $newToken');
      // ابعته للباك إند (Supabase)
    });

    // 📩 Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;

      if (notification != null) {
        LocalNotificationService.show(
          title: notification.title ?? '',
          body: notification.body ?? '',
        );
      }
    });

  }
}
