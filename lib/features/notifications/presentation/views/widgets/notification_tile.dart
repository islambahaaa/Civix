import 'package:cached_network_image/cached_network_image.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/features/notifications/data/models/notification_model.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
    return Slidable(
      key: Key(notification.id),
      useTextDirection: true,
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => onDismiss(notification.id),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),
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
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: notification.image != null
              ? CachedNetworkImage(
                  width: 60,
                  height: 60,
                  imageUrl: notification.image!,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                )
              : null,
        ),
      ),
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
