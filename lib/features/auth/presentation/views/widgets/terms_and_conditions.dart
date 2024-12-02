import 'package:civix_app/features/auth/presentation/views/widgets/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key, required this.onChange});
  final ValueChanged<bool> onChange;
  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  bool isTermsAccepted = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomCheckBox(
          onChecked: (value) {
            isTermsAccepted = value;
            widget.onChange(value);
            setState(() {});
          },
          isChecked: isTermsAccepted,
        ),
        // const TestCheckBox(),
        const SizedBox(
          width: 16,
        ),
        const Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'من خلال إنشاء حساب ، فإنك توافق على ',
                ),
                TextSpan(
                  text: 'الشروط والأحكام',
                ),
                TextSpan(
                  text: ' ',
                ),
                TextSpan(
                  text: 'الخاصة',
                ),
                TextSpan(
                  text: ' ',
                ),
                TextSpan(
                  text: 'بنا',
                ),
              ],
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
