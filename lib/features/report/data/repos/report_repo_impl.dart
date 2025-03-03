import 'package:civix_app/core/errors/failures.dart';
import 'package:civix_app/features/report/domain/repos/report_repo.dart';
import 'package:dartz/dartz.dart';

class ReportRepoImpl implements ReportRepo {
  @override
  Future<Either<Failure, String>> submitReport() {
    // TODO: implement submitReport
    throw UnimplementedError();
  }
}
