import 'dart:convert';
import 'dart:developer';
import 'package:civix_app/constants.dart';
import 'package:civix_app/core/constants/api_constants.dart';
import 'package:civix_app/core/errors/exceptions.dart';
import 'package:civix_app/core/services/shared_prefrences_singleton.dart';
import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;
  DioClient(this.dio) {
    // Add interceptors
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _getToken();
        if (token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException error, handler) {
        return handler.next(error);
      },
    ));
  }

  Future<String> _getToken() async {
    try {
      String? user = await Prefs.getString(kUserData);
      if (user != null) {
        Map<String, dynamic> userMap = jsonDecode(user);
        return userMap['token'] ?? '';
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  Future<Response> authPost(String endpoint, var data,
      {String? fcmToken}) async {
    log('token in dio : $fcmToken');
    return await dio.post(
      '${ApiConstants.baseUrl}${ApiConstants.authEndpoint}$endpoint',
      queryParameters: fcmToken != null ? {'fcmtoken': fcmToken} : null,
      data: data,
    );
  }

  Future<Response> reportPost(String endpoint, FormData formData) async {
    return await dio.post(
      '${ApiConstants.baseUrl}$endpoint',
      data: formData,
      options: Options(headers: {"Content-Type": "multipart/form-data"}),
    );
  }

  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameter}) async {
    return await dio.get(
      '${ApiConstants.baseUrl}$endpoint',
      queryParameters: queryParameter,
    );
  }
}
