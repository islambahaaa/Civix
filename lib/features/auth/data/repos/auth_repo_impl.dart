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
      String password,
      String confirmedPassword) async {
    try {
      var response = await apiAuthService.createUserWithEmailAndPassword(
          fname, lname, email, password, confirmedPassword);
      var userEntity = UserEntity(
          fname: fname, lname: lname, email: email, token: response['token']);
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
    return left(ServerFailure('حدث خطأ غير متوقع'));
    // try {
    //   // var user =
    //   //     await firebaseAuthService.signInWithEmailAndPassword(email, password);
    //   var userEntity = await getUserData(uId: 'user.uid');
    //   await saveUserData(user: userEntity);
    //   return right(userEntity);
    // } on CustomException catch (e) {
    //   return left(ServerFailure(e.message));
    // } catch (e) {
    //   log('Exception in AuthRepoImpl.signInWithEmailAndPassword: ${e.toString()}');

    //   return left(ServerFailure('حدث خطأ غير متوقع'));
    // }
  }

  @override
  Future saveUserData({required UserEntity user}) async {
    // var jsonData = jsonEncode(UserModel.fromUserEntity(user));
    // await Prefs.setString(kUserData, jsonData);
  }

  @override
  Future<Either<Failure, UserEntity>> checkOtp(String email, String password) {
    // TODO: implement checkOtp
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> newPassword(
      String token, String email, String password, String confirmedPassword) {
    // TODO: implement newPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> sendOtp(String email) {
    // TODO: implement sendOtp
    throw UnimplementedError();
  }
}
