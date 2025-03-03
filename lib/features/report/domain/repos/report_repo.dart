import 'package:civix_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ReportRepo {
  Future<Either<Failure, String>> submitReport();
}
