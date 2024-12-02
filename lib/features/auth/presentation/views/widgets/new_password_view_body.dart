import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/core/widgets/custom_button.dart';
import 'package:civix_app/core/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class NewPasswordViewBody extends StatefulWidget {
  const NewPasswordViewBody({super.key});

  @override
  State<NewPasswordViewBody> createState() => _NewPasswordViewBodyState();
}

class _NewPasswordViewBodyState extends State<NewPasswordViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String password, confirmpass;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
      child: SizedBox(
        width: double.infinity,
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                'Create a New Password',
                style: TextStyles.semibold28inter
                    .copyWith(color: AppColors.secondaryColor),
              ),
              const SizedBox(
                height: 29,
              ),
              PasswordField(
                onchanged: (value) {
                  password = value!;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              PasswordField(
                hintText: 'Confirm Password',
                onchanged: (value) {
                  confirmpass = value!;
                },
              ),
              const Spacer(),
              CustomButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (password != confirmpass) {
                        buildSnackBar(context, 'Password does not match');
                      } else {
                        // TODO: implement
                        _showCongratulationsDialog(context);
                        Future.delayed(const Duration(seconds: 5), () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        });
                      }
                    } else {
                      setState(() {
                        autovalidateMode = AutovalidateMode.always;
                      });
                    }
                  },
                  text: 'Verify'),
            ],
          ),
        ),
      ),
    );
  }
}

void _showCongratulationsDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(alignment: Alignment.center, children: [
                  SvgPicture.asset(Assets.imagesVerified),
                  SvgPicture.asset(Assets.imagesBubbles),
                ]),
                const SizedBox(height: 20),
                const Text(
                  'Congratulations!',
                  style: TextStyles.semibold24inter,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Password Reset Successful\nYou’ll be redirected to the login screen now',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      });
}
