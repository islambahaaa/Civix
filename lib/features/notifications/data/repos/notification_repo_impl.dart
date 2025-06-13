import 'package:civix_app/core/errors/failures.dart';
import 'package:civix_app/core/services/notification_service.dart';
import 'package:civix_app/features/notifications/data/models/notification_model.dart';
import 'package:civix_app/features/notifications/domain/repos/notification_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class NotificationRepoImpl implements NotificationRepo {
  final NotificationService notificationService;
  NotificationRepoImpl({required this.notificationService});
  List<NotificationModel>? cachedNotifications;
  @override
  Future<Either<Failure, List<NotificationModel>>> getNotifications() async {
    try {
      if (cachedNotifications != null) return right(cachedNotifications!);
      var data = await notificationService.fetchNotifications();

      List<NotificationModel> notifications = [];
      for (var item in data) {
        var notification = NotificationModel.fromJson(item);

        notifications.add(notification);
      }
      cachedNotifications = notifications;
      return right(notifications);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
