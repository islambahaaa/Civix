import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/features/notifications/data/models/notification_model.dart';
import 'package:civix_app/features/notifications/presentation/views/widgets/notification_tile.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  final List<NotificationModel> notifications = [
    NotificationModel(
      id: '1',
      title: 'New message from Sarah',
      body: 'Hey, are we still meeting tomorrow?',
      time: DateTime.now().subtract(const Duration(minutes: 5)),
      isRead: false,
      icon: Icons.message,
      color: Colors.blue,
      type: 'message',
    ),
    NotificationModel(
      id: '2',
      title: 'Payment received',
      body: 'You\'ve received \$250 from John Doe',
      time: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
      icon: Icons.payment,
      color: Colors.green,
      type: 'payment',
    ),
    NotificationModel(
      id: '3',
      title: 'System update',
      body: 'New version 2.3.0 is available',
      time: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
      icon: Icons.system_update,
      color: Colors.orange,
      type: 'system',
    ),
  ];

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
