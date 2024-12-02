import 'package:civix_app/constants.dart';
import 'package:civix_app/core/services/shared_prefrences_singleton.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:civix_app/features/auth/presentation/views/signin_view.dart';
import 'package:flutter/material.dart';

import 'package:svg_flutter/svg_flutter.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem(
      {super.key,
      required this.image,
      required this.subtitle,
      required this.title,
      required this.isVisible});
  final String image;
  final String subtitle;
  final Widget title;
  final bool isVisible;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Center(
                child: SvgPicture.asset(
              image,
              height: MediaQuery.of(context).size.height * 0.4,
            )),
          ],
        ),
      ),
      const SizedBox(height: 17),
      title,
      const SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Text(
          subtitle,
          style: TextStyles.regular17inter
              .copyWith(color: AppColors.lightGrayColor),
          textAlign: TextAlign.center,
        ),
      ),
    ]);
  }
}
