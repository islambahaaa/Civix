import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/core/widgets/custom_button.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

void showCustomDialog(BuildContext context, String text) {
  showDialog(
      context: context,
      // Prevent dismissing by tapping outside
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
                const Icon(Icons.check_circle,
                    color: AppColors.primaryColor, size: 100),
                const SizedBox(height: 16),
                const Text(
                  'Success!',
                  style: TextStyles.semibold24inter,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  text,
                  style: const TextStyle(
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
                Text(
                  S.of(context).are_you_sure,
                  style: TextStyles.semibold24inter,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  S.of(context).logout_confirm,
                  style: const TextStyle(
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
                          child: Text(S.of(context).cancel,
                              style: TextStyles.semibold16inter.copyWith(
                                color: Colors.black,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        text: S.of(context).logout,
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
