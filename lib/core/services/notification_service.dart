// notification_service.dart
import 'package:civix_app/features/notifications/data/models/notification_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive/hive.dart';

import '../../constants.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static late Box<NotificationModel> notificationBox;

  static Future<void> init() async {
    notificationBox = Hive.box<NotificationModel>(kNotificationsBox);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        final newNotification = NotificationModel(
          id: message.messageId ?? '',
          title: message.notification?.title ?? 'No title',
          body: message.notification?.body ?? 'No body',
          image: message.notification?.android?.imageUrl,
          time: DateTime.now(),
          isRead: false,
        );

        await notificationBox.add(newNotification);
      }
    });
  }
}
