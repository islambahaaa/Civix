import 'dart:async';
import 'dart:developer';

import 'package:civix_app/constants.dart';
import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/core/widgets/custom_button.dart';
import 'package:civix_app/features/auth/presentation/cubits/otp_cubit/otp_cubit.dart';
import 'package:civix_app/features/auth/presentation/views/new_password_view.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../../../../core/widgets/custom_text_form_field.dart';

class OtpViewBody extends StatefulWidget {
  const OtpViewBody(
      {super.key,
      required this.email,
      required this.countdown,
      required this.resendCode});
  final String email;
  final int countdown;
  final VoidCallback resendCode;

  @override
  State<OtpViewBody> createState() => _OtpViewBodyState();
}

String? otp;

class _OtpViewBodyState extends State<OtpViewBody> {
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
                S.of(context).verify,
                style: TextStyles.semibold28inter
                    .copyWith(color: AppColors.secondaryColor),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                S.of(context).enter_code,
                style: TextStyles.medium16inter
                    .copyWith(color: AppColors.lightGrayColor),
              ),
              const SizedBox(
                height: 36,
              ),
              OtpForm(
                onChanged: (value) {
                  if (value.length < 6) {
                    otp = value;
                  }
                },
                onCompleted: (value) {
                  otp = value;
                },
              ),
              const SizedBox(
                height: 64,
              ),
              Text(
                S.of(context).no_code,
                style: TextStyles.medium16inter
                    .copyWith(color: AppColors.lightGrayColor),
              ),
              GestureDetector(
                onTap: widget.countdown == 0 ? widget.resendCode : null,
                child: Text(
                    widget.countdown > 0
                        ? '${S.of(context).resend_code}${widget.countdown} ${S.of(context).seconds_left}'
                        : S.of(context).resend,
                    style: TextStyles.bold15inter),
              ),
              const SizedBox(
                height: 46,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: CustomButton(
                    onPressed: () {
                      if (otp == null || otp!.length < 6) {
                        buildSnackBar(context, S.of(context).otp_digits);
                        return;
                      }

                      BlocProvider.of<OtpCubit>(context)
                          .checkOtp(widget.email, otp!);
                    },
                    text: S.of(context).verify),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OtpForm extends StatelessWidget {
  const OtpForm({super.key, this.onCompleted, this.onChanged});
  final void Function(String)? onCompleted;
  final void Function(String)? onChanged;
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
      onChanged: onChanged,
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
