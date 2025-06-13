import 'package:civix_app/core/constants/api_constants.dart';
import 'package:civix_app/core/services/dio_client.dart';

class NotificationService {
  DioClient dio;

  NotificationService({required this.dio});

  Future<List<dynamic>> fetchNotifications() async {
    final response = await dio.get(ApiConstants.notificationEndpoint);
    final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(
      response.data,
    );
    return data;
  }
}
