import 'package:civix_app/core/constants/api_constants.dart';
import 'package:civix_app/core/errors/exceptions.dart';
import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient(this.dio);
  Future<Map<String, dynamic>> post(String endpoint, var data) async {
    Response response =
        await dio.post('${ApiConstants.baseUrl}$endpoint', data: data);
    return response.data;
  }
}
