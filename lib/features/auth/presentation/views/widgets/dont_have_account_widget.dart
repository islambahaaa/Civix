import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:civix_app/features/auth/presentation/views/sign_up_view.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class DontHaveAccount extends StatelessWidget {
  const DontHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: 'لا تمتلك حساب؟',
              style: TextStyles.semiBold16.copyWith(
                color: AppColors.lightGrayColor,
              )),
          TextSpan(
              text: ' ',
              style: TextStyles.semiBold16.copyWith(
                color: const Color(0xFF616A6B),
              )),
          TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).pushNamed(SignUpView.routeName);
                },
              text: 'قم بإنشاء حساب',
              style: TextStyles.semiBold16.copyWith(
                color: AppColors.primaryColor,
              )),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
