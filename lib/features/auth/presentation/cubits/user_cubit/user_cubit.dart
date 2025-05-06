import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:civix_app/constants.dart';
import 'package:civix_app/core/services/shared_prefrences_singleton.dart';
import 'package:civix_app/features/auth/data/models/user_model.dart';
import 'package:civix_app/features/auth/domain/entities/user_entity.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  String? area;
  Future<void> fetchUser() async {
    emit(UserLoading());
    try {
      String? user = await Prefs.getString(kUserData);
      if (user != null) {
        Map<String, dynamic> userMap = jsonDecode(user);
        final userModel = UserModel.fromJson(userMap);
        area = userModel.area;
        emit(UserSuccess(userModel));
      } else {
        emit(UserFailure(S.current.no_user_data));
      }
    } catch (e) {
      emit(UserFailure("Failed to fetch user: ${e.toString()}"));
    }
  }

  Future<void> saveUser(String email, String fname, String lname,
      String phoneNumber, String areaa) async {
    emit(UserLoading());
    try {
      final UserModel user;
      final userString = await Prefs.getString(kUserData);

      if (userString != null) {
        Map<String, dynamic> userMap = jsonDecode(userString);
        final userModel = UserModel.fromJson(userMap);

        String token = userModel.token;

        user = UserModel(
          email: email,
          fname: fname,
          lname: lname,
          phoneNumber: phoneNumber,
          area: areaa,
          token: token,
        );
      } else {
        user = UserModel(
          email: email,
          fname: fname,
          lname: lname,
          phoneNumber: phoneNumber,
          area: areaa,
          token: "",
        );
      }

      // Save the new user data
      await Prefs.setString(kUserData, jsonEncode(user.toJson()));
      emit(UserSuccess(user));
    } catch (e) {
      emit(UserFailure("Failed to save user: ${e.toString()}"));
    }
  }

  Future<void> logout() async {
    await Prefs.remove(kUserData);
    emit(UserInitial());
  }
}
