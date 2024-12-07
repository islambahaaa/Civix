import 'package:civix_app/core/constants/api_constants.dart';
import 'package:civix_app/core/errors/failures.dart';
import 'package:civix_app/core/services/dio_client.dart';
import 'package:civix_app/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ApiAuthService {
  DioClient dio;
  ApiAuthService(this.dio);
  Future<Map<String, dynamic>> createUserWithEmailAndPassword(
      String fname,
      String lname,
      String email,
      String password,
      String confirmedPassword) async {
    var response = await dio.post(ApiConstants.register, {
      "firstName": fname,
      "lastName": lname,
      "email": email,
      "password": password,
      "confirmedPassword": confirmedPassword,
      "phoneNumber": "011111111",
    });
    return response;
  }
}
