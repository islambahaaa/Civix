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
  Future<void> fetchUser() async {
    emit(UserLoading());
    try {
      String? user = await Prefs.getString(kUserData);
      if (user != null) {
        Map<String, dynamic> userMap = jsonDecode(user);
        emit(UserSuccess(UserModel.fromJson(userMap)));
      } else {
        emit(UserFailure(S.current.no_user_data));
      }
    } catch (e) {
      emit(UserFailure("Failed to fetch user: ${e.toString()}"));
    }
  }

  Future<void> logout() async {
    await Prefs.remove(kUserData);
    emit(UserInitial());
  }
}
