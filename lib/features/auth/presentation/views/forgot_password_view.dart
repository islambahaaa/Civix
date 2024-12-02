import 'package:civix_app/core/widgets/custom_app_bar.dart';
import 'package:civix_app/features/auth/presentation/views/widgets/forgot_password_view_body.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});
  static const String routeName = 'forgot';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: paddingAppbar(text: 'Forgot Password ?', context: context),
      body: const ForgotPasswordViewBody(),
    );
  }
}
