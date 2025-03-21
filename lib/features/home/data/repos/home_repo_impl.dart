import 'package:civix_app/core/errors/failures.dart';
import 'package:civix_app/core/services/api_report_service.dart';
import 'package:civix_app/features/home/data/models/report_model.dart';
import 'package:civix_app/features/home/domain/entities/report_entity.dart';
import 'package:civix_app/features/home/domain/repos/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiReportService apiReportService;

  HomeRepoImpl({required this.apiReportService});
  @override
  Future<Either<Failure, ReportEntity>> fetchMyReports() async {
    try {
      var response = await apiReportService.getMyIssues();
      var report = ReportModel.fromJson(response['data']);
      return right(report);
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
