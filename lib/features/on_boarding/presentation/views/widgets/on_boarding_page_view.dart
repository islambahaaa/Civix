import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/features/on_boarding/presentation/views/widgets/page_view_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        PageViewItem(
          isVisible: true,
          image: Assets.imagesPageview1,
          subtitle: 'report your issues from the comfort of your own house',
          title: Text(
            'COMFORT',
            style: TextStyles.bold28insturment
                .copyWith(color: AppColors.secondaryColor),
          ),
        ),
        PageViewItem(
          isVisible: true,
          image: Assets.imagesPageview2,
          subtitle:
              'Providing you with the trusted authorities to fix your issues ',
          title: Text(
            'TRUST',
            style: TextStyles.bold28insturment
                .copyWith(color: AppColors.secondaryColor),
            textAlign: TextAlign.center,
          ),
        ),
        PageViewItem(
            isVisible: false,
            image: Assets.imagesPageview3,
            subtitle: 'create a safe and peaceful neighborhood',
            title: Text(
              'SAFETY',
              style: TextStyles.bold28insturment
                  .copyWith(color: AppColors.secondaryColor),
            ))
      ],
    );
  }
}
