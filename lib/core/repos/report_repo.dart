import 'dart:io';

import 'package:civix_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ReportRepo {
  Future<Either<Failure, String>> createReport(
    String title,
    String description,
    double latitude,
    double longitude,
    int category,
    List<File> imageFiles,
    String token,
  );
}
