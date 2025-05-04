import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Call this in main() after Firebase.initializeApp()
  static Future<void> initialize() async {
    await _setupFlutterNotifications();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  /// Request permissions (iOS & Android 13+)
  Future<void> requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('🔔 Notification permission granted');
    } else {
      print('🚫 Notification permission denied');
    }
  }

  /// Get FCM token
  Future<String?> getToken() async {
    String? token = await _messaging.getToken();
    print("📱 FCM Token: $token");
    return token;
  }

  /// Handle foreground messages
  void setupOnMessageListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📩 Received a foreground message: ${message.data}');
      if (message.notification != null) {
        _showLocalNotification(message);
      }
    });
  }

  /// Display notification using flutter_local_notifications
  static Future<void> _showLocalNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      _localNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
        ),
      );
    }
  }

  /// Background message handler (must be top-level or static)
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print('📦 Handling background message: ${message.messageId}');
  }

  /// Setup local notification plugin (only once)
  static Future<void> _setupFlutterNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _localNotificationsPlugin.initialize(initializationSettings);
  }
}
