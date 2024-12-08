import 'package:bloc/bloc.dart';
import 'package:civix_app/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this.authRepo) : super(OtpInitial());
  final AuthRepo authRepo;

  Future<void> sendOtp(String email) async {
    emit(SendOtpLoading());

    var result = await authRepo.sendOtp(email);
    result.fold(
      (failure) => emit(SendOtpFailure(failure.message)),
      (response) => emit(SendOtpSuccess(email)),
    );
  }

  Future<void> checkOtp(String email, String otp) async {
    emit(CheckOtpLoading());

    var result = await authRepo.checkOtp(email, otp);
    result.fold(
      (failure) => emit(CheckOtpFailure(failure.message)),
      (token) => emit(CheckOtpSuccess(token)),
    );
  }
}
