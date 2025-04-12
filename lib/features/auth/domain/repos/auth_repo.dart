import 'package:civix_app/core/errors/failures.dart';
import 'package:civix_app/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
    String fname,
    String lname,
    String email,
    String phoneNumber,
    String password,
    String confirmedPassword,
  );

  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      String email, String password);
  Future<Either<Failure, String>> sendOtp(String email);
  Future<Either<Failure, String>> checkOtp(String email, String otp);
  Future<Either<Failure, String>> newPassword(
    String token,
    String email,
    String password,
    String confirmedPassword,
  );
  Future saveUserData({required UserEntity user});
}
