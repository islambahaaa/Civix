import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/repos/auth_repo.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());
  final AuthRepo authRepo;

  Future<void> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    emit(SignupLoading());
    final result =
        await authRepo.createUserWithEmailAndPassword(name, email, password);
    result.fold(
      (failure) => emit(SignupFailure(failure.message)),
      (user) => emit(SignupSuccess(user)),
    );
  }
}
