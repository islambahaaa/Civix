import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class HaveAccountWidget extends StatelessWidget {
  const HaveAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: 'تمتلك حساب بالفعل؟',
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
                  Navigator.of(context).pop();
                },
              text: 'تسجيل دخول',
              style: TextStyles.semiBold16.copyWith(
                color: AppColors.primaryColor,
              )),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
