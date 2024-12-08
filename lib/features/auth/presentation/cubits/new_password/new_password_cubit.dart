import 'package:bloc/bloc.dart';
import 'package:civix_app/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'new_password_state.dart';

class NewPasswordCubit extends Cubit<NewPasswordState> {
  NewPasswordCubit(this.authRepo) : super(NewPasswordInitial());
  final AuthRepo authRepo;
  Future<void> newPassword(String token, String email, String password,
      String confirmedPassword) async {
    emit(NewPasswordLoading());

    var result =
        await authRepo.newPassword(token, email, password, confirmedPassword);
    result.fold(
      (failure) => emit(NewPasswordFailure(failure.message)),
      (response) => emit(NewPasswordSuccess(token)),
    );
  }
}
