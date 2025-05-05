import 'package:civix_app/core/errors/failures.dart';
import 'package:civix_app/core/models/report_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<ReportModel>>> fetchNearMe({String? area});
}
