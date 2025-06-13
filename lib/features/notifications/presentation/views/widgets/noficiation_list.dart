import 'package:civix_app/constants.dart';
import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/core/services/dio_client.dart';
import 'package:civix_app/core/services/get_it_service.dart';
import 'package:civix_app/features/notifications/data/models/notification_model.dart';
import 'package:civix_app/features/notifications/presentation/cubits/cubit/notification_cubit.dart';
import 'package:civix_app/features/notifications/presentation/views/widgets/notification_tile.dart';
import 'package:civix_app/features/report_details/presentation/views/report_details_view.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  List<NotificationModel> notifications = [];

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
    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      final notification = notifications[index];

      if (!notification.isRead) {
        setState(() {
          notification.isRead = true;
        });
      }

      if (notification.issue != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ReportDetailsView(report: notification.issue!),
          ),
        );
      }
    }
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
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: _markAllAsRead,
                child: Text(S.of(context).mark_all_as_read),
              ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh:
                BlocProvider.of<NotificationCubit>(context).getNotifications,
            child: BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                if (state is NotificationLoaded) {
                  notifications = state.notifications;
                  return ListView.separated(
                    padding: const EdgeInsets.only(top: 8),
                    itemCount: notifications.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 0.2, thickness: 0.15),
                    itemBuilder: (context, index) {
                      return NotificationTile(
                        notification: notifications[index],
                        onDismiss: (id) => _dismissNotification(id),
                        onTap: (id) => _handleNotificationTap(id),
                      );
                    },
                  );
                }
                if (state is NotificationError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ],
    );
  }
}
