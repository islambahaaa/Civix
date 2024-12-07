import 'package:bloc/bloc.dart';
import 'package:civix_app/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'send_otp_state.dart';

class SendOtpCubit extends Cubit<SendOtpState> {
  SendOtpCubit(this.authRepo) : super(SendOtpInitial());
  final AuthRepo authRepo;
  Future<void> sendOtp(String email) async {
    emit(SendOtpLoading());
    var result = await authRepo.sendOtp(email);
    result.fold(
      (failure) => emit(SendOtpFailure(failure.message)),
      (response) => emit(SendOtpSuccess(response)),
    );
  }
}
