import 'dart:developer';

import 'package:civix_app/core/constants/api_constants.dart';
import 'package:civix_app/core/services/dio_client.dart';

class ApiSolvedInMyAreaService {
  DioClient dio;

  ApiSolvedInMyAreaService(this.dio);
  Future<List<dynamic>> getAllAreas() async {
    var response = await dio.get(ApiConstants.citiesNames);
    return response.data;
  }

  Future<List<dynamic>> getIssuesInMyArea(String? area) async {
    log("area :${area.toString()}");
    var response = await dio
        .get(ApiConstants.solvedInMyArea, queryParameter: {'area': area});
    log(response.data.toString());
    return response.data;
  }

  Future<String> getAreaBylatlong(double lat, double long) async {
    var response = await dio.get(
      ApiConstants.areaByLatLong,
      queryParameter: {'latitude': lat, 'longitude': long},
    );
    log(response.data.toString());
    return response.data;
  }
}
