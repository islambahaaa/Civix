import 'package:civix_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class PasswordValidator extends StatelessWidget {
  const PasswordValidator(
      {super.key, required this.controller, required this.onFailure});
  final TextEditingController controller;
  final ValueChanged<bool> onFailure;
  @override
  Widget build(BuildContext context) {
    return FlutterPwValidator(
      controller: controller,
      minLength: 8,
      uppercaseCharCount: 1,
      // failureColor: AppColors.primaryColor,
      //successColor: AppColors.secondaryColor,
      numericCharCount: 2,
      specialCharCount: 1,
      normalCharCount: 5,
      width: MediaQuery.of(context).size.width - 60,
      height: MediaQuery.of(context).size.height * 0.20,
      onSuccess: () {
        onFailure(true);
      },
      onFail: () {
        onFailure(false);
      },
    );
  }
}
