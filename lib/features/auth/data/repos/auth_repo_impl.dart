import 'dart:convert';
import 'dart:developer';

import 'package:civix_app/constants.dart';
import 'package:civix_app/core/errors/exceptions.dart';
import 'package:civix_app/core/errors/failures.dart';
import 'package:civix_app/core/services/database_service.dart';

import 'package:civix_app/core/services/shared_prefrences_singleton.dart';
import 'package:civix_app/core/utils/backend_endpoints.dart';
import 'package:civix_app/features/auth/data/models/user_model.dart';
import 'package:civix_app/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  //final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;
  AuthRepoImpl({
    required this.databaseService,
  });
  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      // user = await firebaseAuthService.createUserWithEmailAndPassword(
      //     email, password);
      var userEntity = UserEntity(name: name, email: email, uId: 'user.uid');
      await addUserData(user: userEntity);
      return right(userEntity);
    } on CustomException catch (e) {
      // await deleteUser(user);
      return left(ServerFailure(e.message));
    } catch (e) {
      // if (user != null) {
      //   await firebaseAuthService.deleteUser();
      // }
      log('Exception in AuthRepoImpl.createUserWithEmailAndPassword: ${e.toString()}');

      return left(ServerFailure('حدث خطأ غير متوقع'));
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
      // var user =
      //     await firebaseAuthService.signInWithEmailAndPassword(email, password);
      var userEntity = await getUserData(uId: 'user.uid');
      await saveUserData(user: userEntity);
      return right(userEntity);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in AuthRepoImpl.signInWithEmailAndPassword: ${e.toString()}');

      return left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    // User? user;
    // try {
    //   //user = await firebaseAuthService.signInWithGoogle();
    //   //var userEntity = UserModel.fromFirebaseUser(user);
    //   var isUserExist = await databaseService.isDataExists(
    //       path: BackendEndpoints.isDataExists, docId: user.uid);
    //   if (isUserExist) {
    //     await getUserData(uId: user.uid);
    //   } else {
    //     await addUserData(user: userEntity);
    //   }
    //   await saveUserData(user: userEntity);
    //   return right(userEntity);
    // } catch (e) {
    //   await deleteUser(user);
    //   log('Exception in AuthRepoImpl.signInWithGoogle: ${e.toString()}');

    //   return left(ServerFailure('حدث خطأ غير متوقع'));
    // }
    return left(ServerFailure('حدث خطأ غير متوقع'));
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() async {
    // User? user;
    // try {
    //   user = await firebaseAuthService.signInWithFacebook();
    //   var userEntity = UserModel.fromFirebaseUser(user);
    //   var isUserExist = await databaseService.isDataExists(
    //       path: BackendEndpoints.isDataExists, docId: user.uid);
    //   if (isUserExist) {
    //     await getUserData(uId: user.uid);
    //   } else {
    //     await addUserData(user: userEntity);
    //   }
    //   await saveUserData(user: userEntity);

    //   return right(userEntity);
    // } catch (e) {
    //   await deleteUser(user);
    //   log('Exception in AuthRepoImpl.signInWithFacebook: ${e.toString()}');
    //   return left(ServerFailure('حدث خطأ غير متوقع'));
    // }
    return left(ServerFailure('حدث خطأ غير متوقع'));
  }

  @override
  Future addUserData({required UserEntity user}) async {
    await databaseService.addData(
        path: BackendEndpoints.addUserData,
        data: UserModel.fromUserEntity(user).toMap(),
        docId: user.uId);
  }

  @override
  Future<UserEntity> getUserData({required String uId}) async {
    var data = await databaseService.getData(
        path: BackendEndpoints.getUserData, docId: uId);
    return UserModel.fromJson(data);
  }

  @override
  Future saveUserData({required UserEntity user}) async {
    var jsonData = jsonEncode(UserModel.fromUserEntity(user).toMap());
    await Prefs.setString(kUserData, jsonData);
  }
}
