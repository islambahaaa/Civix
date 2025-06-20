import 'package:civix_app/features/edit_profile/domain/repositories/edit_profile_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this.editProfileRepo) : super(EditProfileInitial());
  final EditProfileRepo editProfileRepo;
  Future<void> getCurrentUser() async {
    emit(EditProfileLoading());
    var result = await editProfileRepo.getCurrentUser();
    result.fold(
      (failure) => emit(EditProfileFailure(failure.message)),
      (user) => emit(EditProfileSuccess(user)),
    );
  }

  Future<void> editCurrentUser(String email, String fname, String lname,
      String phoneNumber, String area) async {
    emit(EditProfileLoading());
    var result =
        await editProfileRepo.editUserProfile(fname, lname, phoneNumber, area);
    result.fold(
      (failure) => emit(EditProfileFailure(failure.message)),
      (_) => emit(EditProfileUpdated(email, fname, lname, phoneNumber, area)),
    );
  }
}
