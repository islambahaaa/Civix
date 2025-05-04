import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/features/notifications/data/models/notification_model.dart';
import 'package:civix_app/features/notifications/presentation/views/widgets/notification_tile.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  List<NotificationModel> notifications = [];
  @override
  void initState() {
    super.initState();
    _listenToFirebaseMessages();
  }

  void _listenToFirebaseMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        final newNotification = NotificationModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: message.notification?.title ?? 'No title',
          body: message.notification?.body ?? 'No body',
          image: message.notification?.android?.imageUrl,
          time: DateTime.now(),
          isRead: false,
          icon: Icons
              .notifications, // You could change this based on `message.data`
          color: Colors.purple,
          type: message.data['type'] ?? 'general', // Default to 'general'
        );

        setState(() {
          notifications.insert(0, newNotification);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).notifications,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextButton(
                onPressed: _markAllAsRead,
                child: Text(S.of(context).mark_all_as_read),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 8),
            itemCount: notifications.length,
            separatorBuilder: (context, index) => const Divider(
              height: 0.2,
              thickness: 0.15,
            ),
            itemBuilder: (context, index) {
              return NotificationTile(
                notification: notifications[index],
                onDismiss: (id) => _dismissNotification(id),
                onTap: (id) => _handleNotificationTap(id),
              );
            },
          ),
        ),
      ],
    );
  }

  void _markAllAsRead() {
    setState(() {
      for (var n in notifications) {
        n.isRead = true;
      }
    });
  }

  void _dismissNotification(String id) {
    setState(() {
      notifications.removeWhere((n) => n.id == id);
    });
    buildSnackBar(context, S.of(context).notification_dismissed);
  }

  void _handleNotificationTap(String id) {
    final notification = notifications.firstWhere((n) => n.id == id);
    setState(() {
      notification.isRead = true;
    });

    // Handle navigation based on notification type
    switch (notification.type) {
      case 'message':
        // Navigate to messages
        break;
      case 'payment':
        // Navigate to payments
        break;
      // Other cases...
    }
  }
}
