import 'package:civix_app/core/errors/failures.dart';
import 'package:civix_app/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class EditProfileRepo {
  Future<Either<Failure, UserEntity>> getCurrentUser();
  Future<Either<Failure, String>> editUserProfile(
      String fname, String lname, String phoneNumber, String area);
}
