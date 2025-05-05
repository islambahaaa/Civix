import 'package:civix_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class PickMyAreaRepo {
  Future<Either<Failure, List<String>>> fetchAreas();
  Future<Either<Failure, String>> fetchAreasBylatlong(double lat, double long);
}
