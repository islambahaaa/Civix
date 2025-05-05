import 'dart:developer';

import 'package:civix_app/core/errors/failures.dart';
import 'package:civix_app/core/services/api_solved_in_my_area_service.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/repos/pick_my_area_repo.dart';

class PickMyAreaRepoImpl implements PickMyAreaRepo {
  final ApiSolvedInMyAreaService apiSolvedInMyAreaService;
  List<String>? cachedAreas;
  PickMyAreaRepoImpl({required this.apiSolvedInMyAreaService});
  @override
  Future<Either<Failure, List<String>>> fetchAreas() async {
    try {
      if (cachedAreas != null) return right(cachedAreas!);
      var response = await apiSolvedInMyAreaService.getAllAreas();
      List<String> areas = List<String>.from(response);
      cachedAreas = areas;
      return right(areas);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(
        e.toString(),
      ));
    }
  }

  @override
  Future<Either<Failure, String>> fetchAreasBylatlong(
      double lat, double long) async {
    try {
      var response = await apiSolvedInMyAreaService.getAreaBylatlong(lat, long);
      if (response == 'Unknown') return left(ServerFailure("No area found"));
      return right(response);
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
