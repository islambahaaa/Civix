import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

void showCongratulationsDialog(BuildContext context) {
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

void showAreYouSureDialog(BuildContext context, VoidCallback onYesPressed) {
  showDialog(
      context: context,
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
                const Text(
                  'Are You Sure!',
                  style: TextStyles.semibold24inter,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Are you sure you want to logout?',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xfff0f0f2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel',
                              style: TextStyles.semibold16inter.copyWith(
                                color: Colors.black,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        text: 'Log Out',
                        onPressed: onYesPressed,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}
