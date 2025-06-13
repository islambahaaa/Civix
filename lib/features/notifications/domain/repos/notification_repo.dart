import 'package:civix_app/core/errors/failures.dart';
import 'package:civix_app/features/notifications/data/models/notification_model.dart';
import 'package:dartz/dartz.dart';

abstract class NotificationRepo {
  Future<Either<Failure, List<NotificationModel>>> getNotifications();
}
