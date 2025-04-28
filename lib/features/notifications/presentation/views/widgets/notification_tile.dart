import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/features/notifications/data/models/notification_model.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
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
          tileColor: notification.isRead
              ? Colors.transparent
              : AppColors.primaryColor.withOpacity(0.1),
          onTap: () => onTap(notification.id),
          minLeadingWidth: 0,
          leading: notification.isRead
              ? null
              : Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
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
    if (diff.inMinutes < 1) return S.current.just_now;
    if (diff.inHours < 1) return '${diff.inMinutes} ${S.current.minutes_ago}';
    if (diff.inDays < 1) return '${diff.inHours} ${S.current.hours_ago}';
    return '${diff.inDays} ${S.current.days_ago}';
  }
}
