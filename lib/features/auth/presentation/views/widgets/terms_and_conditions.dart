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
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'By clicking Sign up, you Agree to our ',
                  style: TextStyles.regular14inter
                      .copyWith(color: AppColors.lightGrayColor),
                ),
                TextSpan(
                  text: 'Terms',
                  style: TextStyles.regular14inter
                      .copyWith(color: AppColors.secondaryColor),
                ),
                const TextSpan(
                  text: ' ',
                ),
                TextSpan(
                  text: 'and',
                  style: TextStyles.regular14inter
                      .copyWith(color: AppColors.secondaryColor),
                ),
                const TextSpan(
                  text: ' ',
                ),
                TextSpan(
                  text: 'Conditions',
                  style: TextStyles.regular14inter
                      .copyWith(color: AppColors.secondaryColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
