import 'dart:async';
import 'dart:developer';

import 'package:civix_app/constants.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/core/widgets/custom_button.dart';
import 'package:civix_app/features/auth/presentation/cubits/otp_cubit/otp_cubit.dart';
import 'package:civix_app/features/auth/presentation/views/new_password_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../../../../core/widgets/custom_text_form_field.dart';

class OtpViewBody extends StatefulWidget {
  const OtpViewBody({super.key, required this.email});
  final String email;

  @override
  State<OtpViewBody> createState() => _OtpViewBodyState();
}

class _OtpViewBodyState extends State<OtpViewBody> {
  int _countdown = 30; // Countdown in seconds
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _startCountdown() {
    setState(() {
      _countdown = 30;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
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

  void _resendCode() {
    BlocProvider.of<OtpCubit>(context).sendOtp(widget.email);
    _startCountdown(); // Restart the countdown
  }

  late String otp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 64,
              ),
              Text(
                'Verify',
                style: TextStyles.semibold28inter
                    .copyWith(color: AppColors.secondaryColor),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                'Enter the code sent to your email',
                style: TextStyles.medium16inter
                    .copyWith(color: AppColors.lightGrayColor),
              ),
              const SizedBox(
                height: 36,
              ),
              OtpForm(
                onCompleted: (value) {
                  otp = value;
                  log(otp);
                },
              ),
              const SizedBox(
                height: 64,
              ),
              Text(
                'Did not receive the code?',
                style: TextStyles.medium16inter
                    .copyWith(color: AppColors.lightGrayColor),
              ),
              GestureDetector(
                onTap: _countdown == 0 ? _resendCode : null,
                child: Text(
                    _countdown > 0
                        ? 'Resend code in $_countdown seconds'
                        : 'Resend Code',
                    style: TextStyles.bold15inter),
              ),
              const SizedBox(
                height: 46,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: CustomButton(
                    onPressed: () {
                      stopTimer();
                      BlocProvider.of<OtpCubit>(context)
                          .checkOtp(widget.email, otp);
                    },
                    text: 'Verify'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OtpForm extends StatelessWidget {
  const OtpForm({super.key, this.onCompleted});
  final void Function(String)? onCompleted;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 64,
      height: 68,
      textStyle:
          TextStyles.medium16inter.copyWith(color: AppColors.secondaryColor),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(16),
      ),
    );
    return Pinput(
      autofocus: true,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      length: 6,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyDecorationWith(
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      onCompleted: onCompleted,
    );
  }
}
