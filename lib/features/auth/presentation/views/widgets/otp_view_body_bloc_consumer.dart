import 'dart:async';

import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/core/widgets/custom_progress_hud.dart';
import 'package:civix_app/features/auth/domain/entities/user_entity.dart';
import 'package:civix_app/features/auth/presentation/cubits/otp_cubit/otp_cubit.dart';
import 'package:civix_app/features/auth/presentation/views/new_password_view.dart';
import 'package:civix_app/features/auth/presentation/views/widgets/otp_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpViewBodyBlocConsumer extends StatefulWidget {
  const OtpViewBodyBlocConsumer({super.key, required this.email});
  final String email;

  @override
  State<OtpViewBodyBlocConsumer> createState() =>
      _OtpViewBodyBlocConsumerState();
}

class _OtpViewBodyBlocConsumerState extends State<OtpViewBodyBlocConsumer> {
  int countdown = 30; // Countdown in seconds
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void startCountdown() {
    setState(() {
      countdown = 30;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  stopTimer() {
    if (timer.isActive) {
      timer.cancel();
    }
  }

  void resendCode() {
    BlocProvider.of<OtpCubit>(context).sendOtp(widget.email);
    startCountdown(); // Restart the countdown
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is CheckOtpSuccess) {
          UserEntity userEntity = UserEntity(
            fname: "",
            lname: "",
            email: widget.email,
            token: state.token,
          );
          Navigator.pushReplacementNamed(context, NewPasswordView.routeName,
              arguments: userEntity);
        }
        if (state is CheckOtpFailure) {
          buildSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is CheckOtpLoading,
          child: OtpViewBody(
            countdown: countdown,
            resendCode: resendCode,
            email: widget.email,
          ),
        );
      },
    );
  }
}
