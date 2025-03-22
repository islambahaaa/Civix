import 'package:civix_app/core/errors/failures.dart';
import 'package:civix_app/features/home/data/models/report_model.dart';
import 'package:civix_app/features/home/domain/entities/report_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<ReportModel>>> fetchMyReports();
}
