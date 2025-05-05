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

  Future<Map<String, dynamic>> getIssuesInMyArea(String? area) async {
    log("area :${area.toString()}");
    var response =
        await dio.get(ApiConstants.solvedInMyArea, queryParameter: area);
    log(response.data.toString());
    return response.data;
  }
}
