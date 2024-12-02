import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/core/widgets/custom_app_bar.dart';
import 'package:civix_app/features/auth/presentation/views/widgets/otp_view_body.dart';
import 'package:flutter/material.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});
  static const String routeName = 'otp';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: otpAppBar(context),
      body: const OtpViewBody(),
    );
  }
}
