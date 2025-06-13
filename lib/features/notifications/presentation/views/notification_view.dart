import 'package:civix_app/core/services/get_it_service.dart';
import 'package:civix_app/features/notifications/domain/repos/notification_repo.dart';
import 'package:civix_app/features/notifications/presentation/cubits/cubit/notification_cubit.dart';
import 'package:civix_app/features/notifications/presentation/views/widgets/noficiation_list.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsView extends StatelessWidget {
  static const routeName = '/notifications';
  const NotificationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NotificationCubit(getIt.get<NotificationRepo>())..getNotifications(),
      child: const Scaffold(body: NotificationList()),
    );
  }
}
