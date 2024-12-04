import 'package:civix_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/Resource/Strings.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class PasswordValidator extends StatelessWidget {
  const PasswordValidator(
      {super.key, required this.controller, required this.onFailure});
  final TextEditingController controller;
  final ValueChanged<bool> onFailure;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FlutterPwValidator(
      controller: controller,
      minLength: 8,
      uppercaseCharCount: 1,
      // failureColor: AppColors.primaryColor,
      // successColor: AppColors.secondaryColor,
      numericCharCount: 1,
      specialCharCount: 1,
      strings: FrenchStrings(),
      width: size.width - 32,
      height: size.height * 0.18 < 104 ? 150 : size.height * 0.18,
      onSuccess: () {
        onFailure(true);
      },
      onFail: () {
        onFailure(false);
      },
    );
  }
}

class FrenchStrings implements FlutterPwValidatorStrings {
  @override
  final String atLeast = 'At least 8 character';
  @override
  final String uppercaseLetters = '1 Uppercase letter';
  @override
  final String numericCharacters = '1 Numeric character';
  @override
  final String specialCharacters = '1 Special character';

  @override
  final String lowercaseLetters = 'Lower Case';

  @override
  final String normalLetters = 'Normal Letters';
}
