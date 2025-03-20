import 'package:civix_app/core/errors/failures.dart';
import 'package:civix_app/core/services/api_report_service.dart';
import 'package:civix_app/features/home/domain/entities/report_entity.dart';
import 'package:civix_app/features/home/domain/repos/home_repo.dart';
import 'package:dartz/dartz.dart';

class HomeRepoImpl implements HomeRepo{
  @override
  Future<Either<Failure, ReportEntity>> fetchMyReports() {
    try {
      var response = await ApiReportService.newPassword(
          token, email, password, confirmedPassword);
      return right(response['message']);
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