import 'package:civix_app/features/notifications/presentation/views/widgets/noficiation_list.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: NotificationList(),
    );
  }
}
