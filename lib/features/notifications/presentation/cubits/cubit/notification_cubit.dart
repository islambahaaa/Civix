import 'package:bloc/bloc.dart';
import 'package:civix_app/features/notifications/data/models/notification_model.dart';
import 'package:civix_app/features/notifications/domain/repos/notification_repo.dart';
import 'package:meta/meta.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.notificationRepo) : super(NotificationInitial());
  final NotificationRepo notificationRepo;
  Future<void> getNotifications() async {
    emit(NotificationLoading());

    final notifications = await notificationRepo.getNotifications();
    notifications.fold(
      (failure) => emit(NotificationError(failure.message)),
      (notifications) => emit(NotificationLoaded(notifications)),
    );
  }
}
