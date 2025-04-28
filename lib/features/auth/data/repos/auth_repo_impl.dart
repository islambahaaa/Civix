import 'dart:convert';
import 'dart:developer';

import 'package:civix_app/constants.dart';
import 'package:civix_app/core/errors/exceptions.dart';
import 'package:civix_app/core/errors/failures.dart';
import 'package:civix_app/core/services/api_auth_service.dart';
import 'package:civix_app/core/services/database_service.dart';

import 'package:civix_app/core/services/shared_prefrences_singleton.dart';
import 'package:civix_app/core/utils/backend_endpoints.dart';
import 'package:civix_app/features/auth/data/models/user_model.dart';
import 'package:civix_app/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  //final FirebaseAuthService firebaseAuthService;
  final ApiAuthService apiAuthService;

  AuthRepoImpl({required this.apiAuthService});

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      String fname,
      String lname,
      String email,
      String phoneNumber,
      String password,
      String confirmedPassword) async {
    try {
      var response = await apiAuthService.createUserWithEmailAndPassword(
          fname, lname, email, phoneNumber, password, confirmedPassword);
      var userEntity = UserEntity(
          fname: fname,
          lname: lname,
          email: email,
          phoneNumber: phoneNumber,
          token: response['token']);
      return right(userEntity);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(
        e.toString(),
      ));
    }
  }

  // Future<void> deleteUser(User? user) async {
  //   if (user != null) {
  //     await firebaseAuthService.deleteUser();
  //   }
  // }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      var response =
          await apiAuthService.signInWithEmailAndPassword(email, password);
      var userEntity = UserModel.fromJson(response);
      saveUserData(user: userEntity);
      return right(userEntity);
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
  Future<Either<Failure, String>> checkOtp(String email, String otp) async {
    try {
      var response = await apiAuthService.checkOtp(email, otp);
      return right(response['token']);
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
  Future<Either<Failure, String>> newPassword(String token, String email,
      String password, String confirmedPassword) async {
    try {
      var response = await apiAuthService.newPassword(
          token, email, password, confirmedPassword);
      return right(response['message']);
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
  Future<Either<Failure, String>> sendOtp(String email) async {
    try {
      var response = await apiAuthService.sendOtp(email);
      return right(response.toString());
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
  Future saveUserData({required UserEntity user}) async {
    final userModel = UserModel.fromUserEntity(user);
    var jsonData = jsonEncode(userModel.toJson());
    await Prefs.setString(kUserData, jsonData);
  }
}
