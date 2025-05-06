import 'package:civix_app/core/constants/api_constants.dart';
import 'package:civix_app/core/errors/failures.dart';
import 'package:civix_app/core/services/dio_client.dart';
import 'package:civix_app/features/auth/domain/entities/user_entity.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ApiAuthService {
  DioClient dio;
  ApiAuthService(this.dio);
  Future<Map<String, dynamic>> createUserWithEmailAndPassword(
      String fname,
      String lname,
      String email,
      String phoneNumber,
      String area,
      String password,
      String confirmedPassword) async {
    var response = await dio.authPost(ApiConstants.register, {
      "firstName": fname,
      "lastName": lname,
      "email": email,
      "password": password,
      "confirmedPassword": confirmedPassword,
      "phoneNumber": phoneNumber,
      "area": area
    });
    return response.data;
  }

  Future<Map<String, dynamic>> signInWithEmailAndPassword(
      String email, String password,
      {String? fcmToken}) async {
    var response = await dio.authPost(
      ApiConstants.login,
      {
        "email": email,
        "password": password,
      },
      fcmToken: fcmToken,
    );
    return response.data;
  }

  Future<String> sendOtp(String email) async {
    var response = await dio.authPost(ApiConstants.sendOtp, {
      "email": email,
    });
    return response.data;
  }

  Future<Map<String, dynamic>> checkOtp(String email, String otp) async {
    var response = await dio.authPost(ApiConstants.checkOtp, {
      "email": email,
      "inputOtp": otp,
    });
    return response.data;
  }

  Future<Map<String, dynamic>> newPassword(String token, String email,
      String password, String confirmedPassword) async {
    var response = await dio.authPost(ApiConstants.newPassword, {
      "email": email,
      "token": token,
      "newPassword": password,
      "confirmedPassword": confirmedPassword,
    });
    return response.data;
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
    var response = await dio.get(ApiConstants.meEndPoint);
    return response.data;
  }

  Future<String> editUserProfile(
    String fname,
    String lname,
    String phoneNumber,
    String area,
  ) async {
    var response = await dio.put(ApiConstants.editProfile, {
      "firstName": fname,
      "lastName": lname,
      "phoneNumber": phoneNumber,
      "area": area
    });
    return response.data;
  }
}
