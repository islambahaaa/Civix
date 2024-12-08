part of 'send_otp_cubit.dart';

@immutable
sealed class SendOtpState {}

final class SendOtpInitial extends SendOtpState {}

final class SendOtpLoading extends SendOtpState {}

final class SendOtpSuccess extends SendOtpState {
  final String email;

  SendOtpSuccess(this.email);
}

final class SendOtpFailure extends SendOtpState {
  final String message;

  SendOtpFailure(this.message);
}
