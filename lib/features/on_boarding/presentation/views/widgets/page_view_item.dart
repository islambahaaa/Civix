import 'package:civix_app/constants.dart';
import 'package:civix_app/core/services/shared_prefrences_singleton.dart';
import 'package:civix_app/features/auth/presentation/views/signin_view.dart';
import 'package:flutter/material.dart';

import 'package:svg_flutter/svg_flutter.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem(
      {super.key,
      required this.image,
      required this.backgroundImage,
      required this.subtitle,
      required this.title,
      required this.isVisible});
  final String image, backgroundImage;
  final String subtitle;
  final Widget title;
  final bool isVisible;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Stack(
          children: [
            Positioned.fill(
                child: SvgPicture.asset(
              backgroundImage,
              fit: BoxFit.fill,
            )),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SvgPicture.asset(
                  image,
                )),
            Visibility(
              visible: isVisible,
              child: GestureDetector(
                onTap: () {
                  Prefs.setBool(kIsOnBoardingSeen, true);
                  Navigator.of(context)
                      .pushReplacementNamed(SigninView.routeName);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'تخط',
                    style: TextStyles.regular13
                        .copyWith(color: AppColors.lightGrayColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 64),
      title,
      const SizedBox(height: 24),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 37),
        child: Text(
          subtitle,
          style: TextStyles.semiBold13.copyWith(color: AppColors.darkGrayColor),
          textAlign: TextAlign.center,
        ),
      ),
    ]);
  }
}
