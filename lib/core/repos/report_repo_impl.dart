import 'dart:developer';
import 'dart:io';

import 'package:civix_app/core/errors/failures.dart';
import 'package:civix_app/core/repos/report_repo.dart';
import 'package:civix_app/core/services/api_report_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ReportRepoImpl implements ReportRepo {
  final ApiReportService apiReportService;
  ReportRepoImpl({required this.apiReportService});
  @override
  Future<Either<Failure, String>> createReport(
    String title,
    String description,
    double latitude,
    double longitude,
    int category,
    List<File> imageFiles,
  ) async {
    try {
      List<MultipartFile> imageMultipartList = await Future.wait(
        imageFiles.map((imageFile) async {
          String fileName = imageFile.path.split('/').last;
          return await MultipartFile.fromFile(
            imageFile.path,
            filename: fileName,
          );
        }),
      );
      var response = await apiReportService.createIssue(title, description,
          latitude, longitude, category, imageMultipartList);
      return right(response['id']);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(
        e.toString(),
      ));
    }
  }

  @override
  Future<Either<Failure, String>> predictImage(File imageFile) async {
    try {
      var response = await apiReportService.predictImage(imageFile);
      return right(response['prediction']);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(
        e.toString(),
      ));
    }
  }
}
