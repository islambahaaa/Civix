import 'dart:developer';

import 'package:civix_app/core/constants/api_constants.dart';
import 'package:civix_app/core/services/dio_client.dart';
import 'package:dio/dio.dart';

class ApiReportService {
  DioClient dio;
  ApiReportService(this.dio);
  Future<Map<String, dynamic>> createIssue(
    String title,
    String description,
    double latitude,
    double longitude,
    int category,
    List<MultipartFile> imageMultipartList,
  ) async {
    FormData formData = FormData.fromMap({
      'title': title,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      // 'categoryId': category,
      'images': imageMultipartList, // Attach image file
    });
    var response = await dio.reportPost(
      ApiConstants.createIssueEndPoint,
      formData,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getMyIssues() async {
    var response = await dio.getMyIssues(ApiConstants.myIssuesEndpoint);
    return response.data;
  }
}
