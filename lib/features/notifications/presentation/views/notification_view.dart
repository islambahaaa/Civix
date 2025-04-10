import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: const NotificationList(),
    );
  }
}

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  final List<NotificationItem> notifications = [
    NotificationItem(
      id: '1',
      title: 'New message from Sarah',
      body: 'Hey, are we still meeting tomorrow?',
      time: DateTime.now().subtract(const Duration(minutes: 5)),
      isRead: false,
      icon: Icons.message,
      color: Colors.blue,
      type: 'message',
    ),
    NotificationItem(
      id: '2',
      title: 'Payment received',
      body: 'You\'ve received \$250 from John Doe',
      time: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
      icon: Icons.payment,
      color: Colors.green,
      type: 'payment',
    ),
    NotificationItem(
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
                'Recent',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextButton(
                onPressed: _markAllAsRead,
                child: const Text('Mark all as read'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 8),
            itemCount: notifications.length,
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              thickness: 0.15,
              indent: 16,
              endIndent: 16,
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notification dismissed')),
    );
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

class NotificationTile extends StatelessWidget {
  final NotificationItem notification;
  final Function(String) onDismiss;
  final Function(String) onTap;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onDismiss,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) => onDismiss(notification.id),
      child: ListTile(
          onTap: () => onTap(notification.id),
          leading: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            margin: const EdgeInsets.only(left: 8),
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: notification.isRead ? Colors.grey : Colors.orange,
              shape: BoxShape.circle,
            ),
          ),
          title: Text(
            notification.title,
            style: TextStyle(
              fontWeight:
                  notification.isRead ? FontWeight.normal : FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(notification.body),
              const SizedBox(height: 4),
              Text(
                timeAgo(notification.time),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          trailing: Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(8)),
          )),
    );
  }

  String timeAgo(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes} min ago';
    if (diff.inDays < 1) return '${diff.inHours} hr ago';
    return '${diff.inDays} d ago';
  }
}

class NotificationItem {
  final String id;
  final String title;
  final String body;
  final DateTime time;
  bool isRead;
  final IconData icon;
  final Color color;
  final String type;

  NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    required this.isRead,
    required this.icon,
    required this.color,
    required this.type,
  });
}
