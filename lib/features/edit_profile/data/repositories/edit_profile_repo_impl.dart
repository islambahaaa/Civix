import 'package:civix_app/core/errors/failures.dart';
import 'package:civix_app/core/services/api_auth_service.dart';
import 'package:civix_app/features/auth/data/models/user_model.dart';

import 'package:civix_app/features/auth/domain/entities/user_entity.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/repositories/edit_profile_repo.dart';

class EditProfileRepoImpl implements EditProfileRepo {
  final ApiAuthService apiAuthService;
  EditProfileRepoImpl(this.apiAuthService);

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      var response = await apiAuthService.getCurrentUser();
      var userEntity = UserModel.fromMe(response);
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
  Future<Either<Failure, String>> editUserProfile(
      String fname, String lname, String phoneNumber, String area) async {
    try {
      var response =
          await apiAuthService.editUserProfile(fname, lname, phoneNumber, area);

      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(
        e.toString(),
      ));
    }
  }
}
