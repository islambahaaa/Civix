import 'package:civix_app/core/errors/failures.dart';
import 'package:civix_app/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      String name, String email, String password);

  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      String email, String password);
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, UserEntity>> signInWithFacebook();
  Future saveUserData({required UserEntity user});
  Future addUserData({required UserEntity user});
  Future<UserEntity> getUserData({required String uId});
}
