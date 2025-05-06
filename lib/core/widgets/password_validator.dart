import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/generated/l10n.dart';
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
      strings: DefineStrings(),
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

class DefineStrings implements FlutterPwValidatorStrings {
  @override
  final String atLeast = S.current.min_chars;
  @override
  final String uppercaseLetters = S.current.uppercase;
  @override
  final String numericCharacters = S.current.numeric;
  @override
  final String specialCharacters = S.current.special_char;

  @override
  final String lowercaseLetters = S.current.lowercase;

  @override
  final String normalLetters = S.current.normal_letters;
}
