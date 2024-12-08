part of 'otp_cubit.dart';

@immutable
sealed class OtpState {}

final class OtpInitial extends OtpState {}

final class SendOtpInitial extends OtpState {}

final class SendOtpLoading extends OtpState {}

final class SendOtpSuccess extends OtpState {
  final String email;

  SendOtpSuccess(this.email);
}

final class SendOtpFailure extends OtpState {
  final String message;

  SendOtpFailure(this.message);
}

final class CheckOtpLoading extends OtpState {}

final class CheckOtpSuccess extends OtpState {
  final String token;

  CheckOtpSuccess(this.token);
}

final class CheckOtpFailure extends OtpState {
  final String message;

  CheckOtpFailure(this.message);
}
