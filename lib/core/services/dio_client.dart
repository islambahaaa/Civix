import 'package:civix_app/core/constants/api_constants.dart';
import 'package:civix_app/core/errors/exceptions.dart';
import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient(this.dio);
  Future<Response> authPost(String endpoint, var data) async {
    Response response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.AuthEndpoint}$endpoint',
        data: data);
    log(response.data.toString());
    log(response.statusCode.toString());
    return response;
  }
}
