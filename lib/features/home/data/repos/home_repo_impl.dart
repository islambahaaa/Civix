import 'package:civix_app/core/errors/failures.dart';
import 'package:civix_app/core/services/api_report_service.dart';
import 'package:civix_app/features/home/data/models/report_model.dart';
import 'package:civix_app/features/home/domain/entities/report_entity.dart';
import 'package:civix_app/features/home/domain/repos/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiReportService apiReportService;

  HomeRepoImpl({required this.apiReportService});
  @override
  Future<Either<Failure, List<ReportModel>>> fetchMyReports() async {
    try {
      var data = await apiReportService.getMyIssues();
      List<ReportModel> reports = [];
      for (var item in data['data']) {
        var report = ReportModel.fromJson(item);
        await report.fetchCityName(); // Fetch city name asynchronously
        print(
            'City: ${report.city}, Date: ${report.date}, Time: ${report.time}');
        reports.add(report);
      }
      return right(reports);
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
