import 'package:civix_app/core/errors/failures.dart';
import 'package:civix_app/core/models/report_model.dart';
import 'package:civix_app/core/services/api_report_service.dart';
import 'package:civix_app/core/services/api_solved_in_my_area_service.dart';
import 'package:civix_app/features/home/domain/repos/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiSolvedInMyAreaService apiSolvedInMyAreaService;

  HomeRepoImpl({required this.apiSolvedInMyAreaService});
  @override
  Future<Either<Failure, List<ReportModel>>> fetchNearMe({String? area}) async {
    try {
      var data = await apiSolvedInMyAreaService.getIssuesInMyArea(area);
      List<ReportModel> reports = [];
      for (var item in data) {
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
