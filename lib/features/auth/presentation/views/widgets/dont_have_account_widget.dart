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
          const TextSpan(
            text: 'لا تمتلك حساب؟',
          ),
          const TextSpan(
            text: ' ',
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.of(context).pushNamed(SignUpView.routeName);
              },
            text: 'قم بإنشاء حساب',
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
